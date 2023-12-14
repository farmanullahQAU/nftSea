// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.20;
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";




contract NftMarketPlace is ERC721URIStorage, Ownable{ 


    // constructor() ERC721("GameItem", "ITM") {
    // }

      constructor(string memory name, string memory symbol) ERC721(name, symbol) Ownable(msg.sender) {

    }





}