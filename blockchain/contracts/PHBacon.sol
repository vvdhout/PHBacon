pragma solidity ^0.5.1;

contract PHBacon {
    
    /* This contract should enable to following options:
    - Get contract balance
    - Deposit value into the fund
    - Withdraw value from the fund. Size of value is rate limited (can only withdraw half of contributionBalance,
      when verified, with a max of 0.5ETH per week.)
    - We can link a PH account to our address (verification needed).
    - Withdrawls and deposits emit an event.
    - Withdrawls and deposit can have a message associated with the transaction.
    */
    
    /* The goal is to keep the contract and all blockchain-based operations incredibly simple and straightforward
    as such that it makes potential bugs and loopholes less common. */
    
    // ===== WARNING: This version is using a push system for transfers. Can be converted to a pull system where we
    // ===== maintain an extractable balance for each address and enable withdraw function that solely transfers.
    
    // ============= VARIABLES =============
    
    // Setting owner of the contract
    address private owner;
    
    // Enabling pausability -> We first want to get sufficient funds in before we enable withdrawls.
    bool private withdrawPaused = true;
    
    // Setting Maker struct template that holds maker data
    struct Maker {
        uint contributionBalance;
        string PHusername;
        string imgurl;
        bool verified;
    }
    
    // Mapping address to a Maker
    mapping (address => Maker) public addressToMaker;
    
    
    constructor() public {
        owner = msg.sender;
    }
    
    
    // ============= EVENTS =============
    event Transaction(bytes32 indexed _type, uint indexed _value, address indexed _maker, string _msg);
    
    
    // ============= MODIFIERS =============
    
    // Require that the msg.sender is the owner
    modifier isOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }
    
    // Require that withdrawls are not paused
    modifier notPaused() {
        require(withdrawPaused == false, "Withdrawls are currently paused.");
        _;
    }
    
    // Require that the msg.sender is a verified address
    modifier verified() {
        require(addressToMaker[msg.sender].verified == true, "Address has not been verified.");
        _;
    }
    
    
    // ============= FUNCTIONS =============
    
    // Allowing anybody to query the funds value
    function getFundBalance() public view returns (uint) {
        return address(this).balance;
    } 

    // Get maker information using an address
    function getMaker(address _address) public view returns(string memory, uint, string memory, bool) {
        Maker memory getM = addressToMaker[_address];
        return(getM.PHusername,getM.contributionBalance,getM.imgurl,getM.verified);
    }

    // Become a maker and request verification
    function becomeMaker(string memory _username, string memory _imageurl) public payable {
        require(msg.value > 0.1 ether, "In order to become a maker you need to send over at least 0.10 ETH with the function call.");
        addressToMaker[msg.sender].PHusername = _username;
        addressToMaker[msg.sender].imgurl = _imageurl;
        // Emit deposit event
        emit Transaction("deposit", msg.value, msg.sender, "Registered as a maker!");
    }
    
    // Allowing anybody to deposit funds, even non-verified makers
    function deposit(string memory _msg) public payable {
        // Access Maker and increase contributionBalance
        Maker storage depM = addressToMaker[msg.sender];
        depM.contributionBalance += msg.value;
        // Emit deposit event
        emit Transaction("deposit", msg.value, msg.sender, _msg);
    }
    
    // Allowing the wirthdrawl of funds by verified makers, capped at 0.5ETH per week, and 
    // value dependent on contributionBalance with a max debt of 1 ETH per maker (assymptote)
    function withdraw(uint _value, string memory _msg) public notPaused() verified() {
        // Set max withdrawl
        uint max = addressToMaker[msg.sender].contributionBalance / 2;
        require(_value <= max, "Sorry, you can only extract half of your contributionBalance in Wei.");
        require(bytes(_msg).length > 0, "Make sure to add a message explaining your withdrawl.");
        // Access Maker and decrease contributionBalance
        Maker storage withM = addressToMaker[msg.sender];
        withM.contributionBalance -= _value;
        // Transfer funds
        msg.sender.transfer(_value);
        // Emit withdrawl event
        emit Transaction("withdrawl", _value, msg.sender, _msg);
    }
    
    // Set verified address
    function verify(address _makerAddress) public isOwner() {
        addressToMaker[_makerAddress].verified = true;
        addressToMaker[_makerAddress].contributionBalance += 1000000000000000000;
    }
    
    // Pause or re-open withdrawls 
    function pause(bool _bool) public isOwner() {
        withdrawPaused = _bool;
    }
    
}