// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./ERC721.sol";
import "./IERC721Metadata.sol";
import "./IERC721Enumerable.sol";

contract FakeBayc is ERC721 {

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function burn(uint256 tokenId) external {
        // only the owner can burn a token
        require(msg.sender == _ownerOf[tokenId], "not owner");
        _burn(tokenId);
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // Check if token exists
        require(_ownerOf[tokenId] != address(0), "token doesn't exist");
        string memory baseURI = "https://ipfs.io/ipfs/QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
        return string(abi.encodePacked(baseURI, tokenId));
    }
}
