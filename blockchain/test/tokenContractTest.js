const tokenContract = artifacts.require("tokenContract");

contract("tokenContract test", async accounts => {

  it("should do this", async () => {
    // Get deployed contract
    let instance = await tokenContract.deployed();
    // Perform a function of the contract
    await instance.function1(arg1, arg2, {from: accounts[0]});
    // Store the result of another function of the contract
    let result = await instance.function2(arg1, arg2);
    // Assert if result is equal to something, and if not send a message
    assert.equal(result, "equal this", "it did not do this");
  })

});