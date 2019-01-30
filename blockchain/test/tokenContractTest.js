const PHBaconContract = artifacts.require("PHBaconContract");

contract("PHBaconContract test", async accounts => {

  it("should be able to show our fund balance", async () => {
    // Get deployed contract
    let instance = await PHBaconContract.deployed();
    // Perform a function of the contract
    let result = await instance.getFundBalance({from: accounts[0]});
    // Assert if result is equal to something, and if not send a message
    assert.isNumber(result, "getFundBalance does not return a number");
    assert.equal(result, 0, "getFundBalance does not equal 0")
  })

});