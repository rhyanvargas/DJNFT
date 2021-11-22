require('dotenv').config();


const main = async () => {
  // Compile Contract.
  const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFT');
  // Spin up local blockckchain
  const nftContract = await nftContractFactory.deploy();
  // Contract mined and deployed on mock blockchain
  await nftContract.deployed();
  
  console.log("Contract Deployed: ", nftContract.address);

  // Call minting function
  let txn = await nftContract.mintNFT();
  // Wait for minting to complete...
  await txn.wait();
  console.log('NFT #1 Minted...')

  // Call 2nd minting function
   txn = await nftContract.mintNFT();
  //  Wait for minting to complete...
   await txn.wait();
   console.log('NFT #2 Minted...')

};


const runMain = async () => {
  try {
    await main();
    process.exit(0)
  } catch(error) {
    console.log(error);
    process.exit(1);
  }
}


runMain();