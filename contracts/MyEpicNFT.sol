// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import {Base64} from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage{
  // OpenZeppelin: Keep track of tokens
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // Generic variable for all NFTs to use
  string baseSVG = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

  // Random string arrays
  string[] djNames = [
    "Laidback Luke",
    "Avicii",
    "Diplo",
    "Swedish House Mafia",
    "Steve Aoki",
    "David Guetta",
    "IMV",
    "DJ Chuckie"
  ];
  string[] verbs = [
    "eats",
    "punches",
    "scratches",
    "jumps",
    "parties",
    "mixes",
    "yells",
    "lifts",
    "produces"
  ];
  string[] nouns = [
    "beats",
    "tracks",
    "vinyl",
    "samples",
    "bangers",
    "turntables",
    "crowds",
    "records",
    "fruity loops"
  ];

  event NewEpicNftMinted(address sender, uint256 tokenId);


  // Pass name of token and it's symbol 
  constructor() ERC721 ("DJNFT", "DJNFT"){
      console.log('This is my new contract!');
  }

  // randomly generate word combos...
  function pickFirstWord(uint256 tokenId) public view returns (string memory){
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    rand = rand % djNames.length;
    return djNames[rand];
  }

  function pickSecondWord(uint256 tokenId) public view returns (string memory){
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % verbs.length;
    return verbs[rand];
  }

  function pickThirdWord(uint256 tokenId) public view returns (string memory){
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % nouns.length;
    return nouns[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  // User makes a NFT using this function...
  function mintNFT() public {
    // Get current token Id, starting at 0
    uint256 newTokenId = _tokenIds.current();

    // Get random words...
    string memory firstWord = pickFirstWord(newTokenId);
    string memory secondWord = pickSecondWord(newTokenId);
    string memory thirdWord = pickThirdWord(newTokenId);
    string memory combinedWord = string(abi.encodePacked(firstWord," ",secondWord," ",thirdWord));
    // Combine words into the SVG
    string memory newSVG = string(abi.encodePacked(baseSVG, combinedWord, "</text></svg>"));

    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // We set the title of our NFT as the generated word.
                    combinedWord,
                    '", "description": "A highly acclaimed collection of Dj Shirts.", "image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(newSVG)),
                    '"}'
                )
            )
        )
    );

    // Just like before, we prepend data:application/json;base64, to our data.
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );
    console.log('\n------------------');
    console.log(newSVG);
    console.log('------------------\n');
    console.log('\n------------------');
    console.log(
    string(
        abi.encodePacked(
            "https://nftpreview.0xdev.codes/?code=",
            finalTokenUri
        )
    )
);
    console.log('------------------\n');

    // Mint NFT and send to user who uses 'msg.sender' 
    _safeMint(msg.sender, newTokenId);

    // Set NFT data
    _setTokenURI(newTokenId, finalTokenUri);

    // Increment NFT count for the next NFT
    _tokenIds.increment();

    console.log("An NFT w/ ID %s has been minted to %s", newTokenId, msg.sender);

    emit NewEpicNftMinted(msg.sender, newTokenId);

  }
}