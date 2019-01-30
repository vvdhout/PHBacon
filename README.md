# PHBacon

PHBacon is a collectively maintained fund for makers maintained by makers. This repository will hold all files pertaining the application (front-end, testing, smart contracts, and more). PHBacon will be a cryptocurrency fund (particularly an ETH fund) that allows makers to donate and withdraw with the goal of supporting the creation of amazing projects, products, and services.

## Details

PHBacon will initially be a single page platform that will show the collective fund and its holdings as well as changes to the fund over time (graph of its contents, changes in the last 24 hours). It will also present the option for makers to deposit funds into vault as well as withdraw funds (this will be rate limited based on maker reputation). Deposits and withdrawls, especially big ones, will be broadcasted publicly on the page as well as on social media pages, to make sure that makers reputation is held accountable. Makers can also add messages to their depososit or withdrawl transactions to elaborate on their motivation for the action. Initially, we will set the PHBacon reputation equal to the balance of a makers desposits and withdrawals. 

PHBacon will be an application that uses traditional programming languages for the front-end design (such as HTML, CSS, Javascript/jQuery) but will run back-end operations such as storing reputation, managing the fund, enabling deposit and withdrawl options on the Ethereum blockchain (web3.js and Solidity). Development and testing will be done using Truffle. Version control will be done in Git.