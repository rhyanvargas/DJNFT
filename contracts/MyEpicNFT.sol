// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import 'hardhat/console.sol';

contract MyEpicNFT is ERC721URIStorage{
  // OpenZeppelin: Keep track of tokens
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // Pass name of token and it's symbol 
  constructor() ERC721 ("TurntableNFT", "DECKS"){
      console.log('This is my new contract!');
  }

  // User makes a NFT using this function...
  function mintNFT() public {
    // Get current token Id, starting at 0
    uint256 newTokenId = _tokenIds.current();

    // Mint NFT and send to user who uses 'msg.sender' 
    _safeMint(msg.sender, newTokenId);

    // Set NFT data
    _setTokenURI(newTokenId, "https://raw.githubusercontent.com/rhyanvargas/turntable-nft-draft/main/metadata/turntable.json");

    // Increment NFT count for the next NFT
    _tokenIds.increment();

    console.log("An NFT w/ ID %s has been minted to %s", newTokenId, msg.sender);

  }
}