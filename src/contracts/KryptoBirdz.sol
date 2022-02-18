// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract Kryptobird is ERC721Connector {

    //initialize this contract to inherit name and symbol from erc721metadata
   constructor() ERC721Connector('Kryptobird', 'KBIRDZ'){
       
   }    
}