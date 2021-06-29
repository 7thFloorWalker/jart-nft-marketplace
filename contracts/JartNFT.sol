// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract JartNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(string => uint8) hashes;
    address contractAddress;

    //constructor(address marketplaceAddress) ERC721("Jerrys Artarama Art NFT Market", "JART") {
    //    contractAddress = marketplaceAddress;
    //}
    constructor() ERC721("Jerrys Artarama Art NFT Market", "JART") {

    }

    function createToken(address recipient, string memory hash, string memory metadata)
        public
        returns (uint256)
    {
        //make sure now JART NFT exists with this hash
        require(hashes[hash] != 1);
        hashes[hash] = 1;
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        //mint NFT using minter address and hash
        _mint(recipient, newItemId);
        //set URI to IPFS metadata
        _setTokenURI(newItemId, metadata);

        setApprovalForAll(contractAddress, true);
        return newItemId;
    }
}