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
        uint256 indexed tokenId);

    event Approval(
        address indexed owner,
        address indexed approved,
        address indexed tokenId);

    //Mapping from token id to owner
    mapping(uint256 => address) private _tokenOwner; 

    //Mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    //Mapping from tokenID to approve addresses
    mapping(uint256 => address) private _tokenApprovals;


    // @notice Count all NFTs assigned to an owner
    // @dev NFTs assigned to the zero address are considered invalid, and this
    //  function throws for queries about the zero address.
    // @param _owner An address for whom to query the balance
    // @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view returns (uint256){
        require(_owner != address(0), "Address cannot be a zero address");
        return _OwnedTokensCount[_owner];
    }

    // @notice Find the owner of an NFT
    // @dev NFTs assigned to zero address are considered invalid, and queries
    //  about them do throw.
    // @param _tokenId The identifier for an NFT
    // @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) public view returns (address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "Address does not exist");
        return owner;
    }


    function _exists(uint256 tokenId) internal view returns(bool){
        //setting the address from tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];
        //return if the adress is not 0
        return owner != address(0);
    }

    //Minting function
    function _mint(address to, uint256 tokenId) internal virtual{
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

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer

    function _transferFrom(address _from, address _to, uint256 _tokenId) public payable{
        require(_to != address(0), "Erro - ERC721 Transfer to zero address");
        require(ownerOf(_tokenId) == _from, "you do not own this NFT");

        _OwnedTokensCount[_from] -= 1;
        _OwnedTokensCount[_to] += 1;

        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public payable{
        _transferFrom(_from, _to, _tokenId);
    }

     /// @notice Change or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    ///  Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param _approved The new approved NFT controller
    /// @param _tokenId The NFT to approve
    function approve(address _approved, uint256 _tokenId) external payable;

}

// function that will clear the NFT