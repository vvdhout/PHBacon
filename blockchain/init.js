// ================= Initializing test version in truffle console

let deployScript = async () => {

	// Set accounts 0-10
	let acc = await web3.eth.getAccounts()

	// Set instance to connect to the deployed contract
	let inst = await PHBacon.deployed()

	// Deposit with a maker account
	inst.deposit({from: acc[0], value: web3.utils.toWei('0.14', 'ether')})

	// Become a maker
	inst.becomeMaker('account0', 'https://previews.123rf.com/images/drawkman/drawkman1709/drawkman170900234/85465524-cartoon-monster-face-isolated-vector-halloween-blue-happy-monster-square-avatar-design-for-t-shirt-s.jpg', {from: acc[0], value: web3.utils.toWei('0.11')})

	// Verify acc[0] as maker
	inst.verify(acc[0], {from: acc[0]})

	// Unpause the contract withdawls
	inst.pause(false, {from: acc[0]})

	// Deposit as a maker
	inst.deposit({value: web3.utils.toWei('0.55'), from: acc[0]})

	// Withdraw as a verified maker
	inst.withdraw(web3.utils.toWei('0.13'), {from: acc[0]})
}