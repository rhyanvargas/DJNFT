# Basic NFT - DJNFT
*Hardhat // Solidity // React* 

**View site here: https://nft-starter-project.rhyanvargas.repl.co/**
===

This project demonstrates a basic NFT `ERC721` token contract, and script that deploys that contract.

Try running some of the following tasks:
### Install Dependencies
`npm install`

### Add environment variables
```
RINKEBY_KEY={YOUR_KEY_HERE}
ALCHEMY_URL_KEY=https://eth-rinkeby.alchemyapi.io/v2/{YOUR_KEY_HERE}
```
### Run Contract Locally
`npx hardhat run scripts/run.js`

### Deploy Contract to Rinkeby Testnet
`npx hardhat run scripts/deploy.js --network rinkeby`

## TODO
[ ] Create `_totalSupply` so that there is a limited supply  
[ ] Add `totalMinted` so that user can see how many has been minted  
[ ] Add dynamic background color change to NFT svg
[ ] Verify a contract using this terminal command
```shell
npx hardhat verify {CONTRACT_ADDRESS} --network _totalSupply`
```
