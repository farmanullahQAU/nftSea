// SPDX-License-Identifier: MIT
 
 
 pragma solidity ^0.8.20;
import {ERC721URIStorageUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";

import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "hardhat/console.sol";


// import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract NFTSS is Initializable,ERC721Upgradeable,ERC721URIStorageUpgradeable{ 
mapping(uint=>NFT) public listedTokens;

uint _totalItemSold;

event Added(NFT);

 uint256 private _nextTokenId;

   uint256 charges; //0.0001 ehter ; //listing charges by marketplace

function initialize() public initializer {

        __ERC721_init("MyToken", "MTK");

   charges=100000000000000 wei; //0.0001 ehter ; //listing charges by marketplace

    
        
    }

//  constructor() initializer {}
//   constructor() {
//         _disableInitializers();
//     }

//     function initialize() initializer public {
//         __ERC721_init("MyToken", "MTK");

//   charges=100000000000000 wei; //0.0001 ehter ; //listing charges by marketplace

//     }


  struct NFT{
    address creator;
address owner;
uint price;
string uri;
bool isSold;
  }








  

      function createNFT(string memory uri,uint price) public payable{


    

      require(price>charges,"Price should be greater than listing price");
    
        uint256 tokenId = _nextTokenId++;
     
        _mint(address(this), tokenId);  //use _safeMint if we keep ownership to msg.sender
        _setTokenURI(tokenId, uri);



        _createMarketItem(uri,price,tokenId);
    }

function _createMarketItem( string memory uri,uint price,uint tokenId) public   {

           listedTokens[tokenId]=NFT(address(msg.sender),address(this),
          price,uri,false);

emit Added(listedTokens[tokenId]);

}


// function sellNFT(uint tokenId)public payable {
// require(listedTokens[tokenId].isSold==false,"Already sold");
// uint price=listedTokens[tokenId].price *1 ether;
// address seller=listedTokens[tokenId].creator;
// require(msg.value==price ,"Please submit the asking price in order to continue");

// _transfer(address(this), msg.sender, tokenId); //transfer ownership of nft from market to buyer
// payable(address(this)).transfer(charges);// deduct listing chrges from seller

// payable(seller).transfer(msg.value); //transfer amount to seller
// listedTokens[tokenId].isSold=true;
// _totalItemSold++;

// }

function sellNFT(uint tokenId) public payable {
  // Check if NFT is already sold
  require(listedTokens[tokenId].isSold == false, "NFT already sold");

  // Get price and seller address
  uint price = listedTokens[tokenId].price;
  address seller = listedTokens[tokenId].creator;

  // Ensure buyer sent correct price
  require(msg.value == price , "Please send the exact asking price to proceed");

  // Transfer NFT ownership to buyer (let buyer pay gas)
  _transfer(address(this), msg.sender, tokenId);

  // Deduct listing charges from seller payment
  
   // Send remaining payment to seller after deducting charges
  uint sellerPayment = msg.value - charges;
  payable(seller).transfer(sellerPayment);
  // Update NFT status and counter
  listedTokens[tokenId].isSold = true;


  _totalItemSold++;
}







function getAllNftOfOwner() public view returns (NFT[] memory) {


uint total=balanceOf(address(this));

console.log(total);
    NFT[] memory nfts = new NFT[](total);
    for (uint i = 0; i < total; i++) {
     
            nfts[i] = listedTokens[i];
        
    }
    return nfts;
}
/*
function getAllNftOfOwner() public view returns (NFT[] memory) {
    uint total = balanceOf(msg.sender);
    NFT[] memory nfts = new NFT[](total);

    for (uint i = 0; i < total; i++) {
        uint tokenId = tokenOfOwnerByIndex(msg.sender, i);
        nfts[i] = listedTokens[tokenId];
    }

    return nfts;
}*/


function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }


}
