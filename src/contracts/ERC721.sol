// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    /*
    building out the minting function
    1. NFT to point to an address
    2. Keep track of the tokenids
    3. Keep track of token owner addresses to token ids
    4. keep track of how many tokens an owner address has
    5. Emit and logs (event that emits a transfer log) - contract address, where is it minted to, the id
    */

contract ERC721{

    //Event transfer to keep track of minting token
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId
    );

    //Mapping from token id to owner
    mapping(uint256 => address) private _tokenOwner; 

    //Mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    function _exists(uint256 tokenId) internal view returns(bool){
        //setting the address from tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];
        //return if the adress is not 0
        return owner != address(0);
    }

    //Minting function
    function _mint(address to, uint256 tokenId) internal{
        //requires that the address isnt zero
        require(to != address(0),'ERC721: minting to the zero address');
        //requires that the token does not exisit
        require(!_exists(tokenId), 'ERC721: token already minted');
        //Adding a new address with a token id for minting
        _tokenOwner[tokenId] = to;
        //Keeping each address that is minting
        _OwnedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }
}