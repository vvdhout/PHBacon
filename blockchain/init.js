// Initializing test version in truffle console

let acc = await web3.eth.getAccounts()
let ins = await PHBacon.deployed()
ins.deposit({from: acc[0], value: web3.utils.toWei('0.14', 'ether')})
ins.deposit({from: acc[1], value: web3.utils.toWei('0.09', 'ether')})
ins.deposit({from: acc[2], value: web3.utils.toWei('0.1', 'ether')})