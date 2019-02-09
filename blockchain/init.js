// Initializing test version in truffle console

let acc = await web3.eth.getAccounts()
let inst = await PHBacon.deployed()
inst.deposit({from: acc[0], value: web3.utils.toWei('0.14', 'ether')})
inst.deposit({from: acc[1], value: web3.utils.toWei('0.09', 'ether')})
inst.deposit({from: acc[2], value: web3.utils.toWei('0.1', 'ether')})