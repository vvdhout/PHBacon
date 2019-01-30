pragma solidity ^0.5.3;

contract PHBacon {
    
    /* This contract should enable to following options:
    - Get contract balance
    - Deposit value into the fund
    - Withdraw value from the fund. Size of value is rate limited (always lower than 0.5ETH per week for an address and dependent on their reputation)
    - We can link a PH account to our address (verification needed).
    - Withdrawls and deposits emit an event.
    - Withdrawls and deposit can have a message associated with the transaction.
    */
    
    // WARNING: This version is using a push system for transfers. Can be converted to a pull system where we
    // maintain an extractable balance for each address and enable withdraw function that solely transfers.
    
    // Setting owner of the contract
    address private owner;
    
    // Setting Maker struct template that holds maker data
    struct Maker {
        uint contributionBalance;
        string PHusername;
        bool verified;
    }
    
    // Mapping address to a Maker
    mapping (address => Maker) public addressToMaker;
    
    constructor() public {
        owner = msg.sender;
    }
    
    // Require that the msg.sender is the owner
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    // Require that the msg.sender is a verified address
    modifier verified() {
        require(addressToMaker[msg.sender].verified == true, "Address has not been verified.");
        _;
    }
    
    // Allowing anybody to query the funds value
    function getFundBalance() public view returns (uint) {
        return address(this).balance;
    } 
    
    // Allowing anybody to deposit funds, even non-verified makers
    function deposit() public payable {
        Maker storage depM = addressToMaker[msg.sender];
        depM.contributionBalance += msg.value;
    }
    
    // Allowing the wirthdrawl of funds by verified makers, capped at 0.5ETH per week, and 
    // value dependent on contributionBalance with a max debt of 1 ETH per maker (assymptote)
    function withdraw(uint _value) public verified() {
        // Set max withdrawl
        uint max = addressToMaker[msg.sender].contributionBalance / 2;
        require(_value <= max, "Sorry, you can only extract half of your contributionBalance in Wei.");
        Maker storage withM = addressToMaker[msg.sender];
        withM.contributionBalance -= _value;
        msg.sender.transfer(_value);
    }
    
    // Set verified address
    function verify(address _makerAddress) public isOwner() {
        addressToMaker[_makerAddress].verified = true;
        addressToMaker[_makerAddress].contributionBalance += 1000000000000000000;
    }
    
}