// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./IERC721.sol";
import "./IERC721Receiver.sol";

contract ERC721 is IERC721 {
    event Transfer(address indexed from, address indexed to, uint256 indexed id);
    event Approval(address indexed owner, address indexed spender, uint256 indexed id);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    // Mapping from the token id to owner address
    mapping(uint256 => address) internal _ownerOf;

    // Mapping from owner address to token count
    mapping(address => uint256) internal _balanceOf;

    // Mapping from token ID to approved address (spender)
    mapping(uint256 => address) internal _approvals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) public isApprovedForAll;

    // Implementation of IERC165
    function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        // type(xxx).interfaceId returns 4 bytes
        return interfaceId == type(IERC721).interfaceId || interfaceId == type(IERC165).interfaceId;
    }

    // Implementation of IERC721
    function ownerOf(uint256 tokenId) external view returns (address owner) {
        // get the owner of a token ID
        owner = _ownerOf[tokenId];

        // Check if the token has an owner
        require(owner != address(0), "token doesn't exist");
    }

    // Implementation of IERC721
    function balanceOf(address owner) external view returns (uint256 balance) {
        // Check if the owner is valid
        require(owner != address(0), "Owner can't be 0");

        // Get the balance of a owner
        balance = _balanceOf[owner];
    }

    // Implementation of IERC721
    function setApprovalForAll(address operator, bool _approved) external {
        // Set to true if the msg.sender gave permissions to operator; Otherwise, set to false
        isApprovedForAll[msg.sender][operator] = _approved;

        emit ApprovalForAll(msg.sender, operator, _approved);
    }

    // Implementation of IERC721
    function approve(address to, uint256 tokenId) external {
        address owner = _ownerOf[tokenId];
        // Only the owner or authorized operator can call this function
        require(msg.sender == owner || isApprovedForAll[owner][msg.sender], "not authorized");

        // Give permission to to address
        _approvals[tokenId] = to;

        emit Approval(msg.sender, to, tokenId);
    }

    // Implementation of IERC721
    function getApproved(uint256 tokenId) external view returns (address operator) {
        // Check if the token has an owner
        require(_ownerOf[tokenId] != address(0), "token doesn't exist");
        operator = _approvals[tokenId];
    }

    function _isApprovedOrOwner(
        address owner,
        address spender,
        uint256 tokenId
    ) internal view returns (bool) {
        // Check if
        // 1. the spender is the owner
        // 2. the owner has approve the spender
        // 3. the spender has approval of the token
        return spender == owner || isApprovedForAll[owner][spender] || spender == _approvals[tokenId];
    }

    // Implementation of IERC721
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        // Check if from address owns the token
        require(from == _ownerOf[tokenId], "not owner");

        // Check if to address is not zero
        require(to != address(0), "invalid to address");

        // Check if the caller has the permission to send the token
        require(_isApprovedOrOwner(from, msg.sender, tokenId), "not authorized");

        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[tokenId] = to;

        delete _approvals[tokenId];

        emit Transfer(from, to, tokenId);
    }

    // Implementation of IERC721
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external {
        transferFrom(from, to, tokenId);

        // Check if
        // 1. the to address is not a contract
        // 2. to address is valid receiver
        require(
            to.code.length == 0 ||
                IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, "") ==
                IERC721Receiver.onERC721Received.selector,
            "unsafe recepient"
        );
    }

    // Implementation of IERC721
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external {
        transferFrom(from, to, tokenId);

        // Check if
        // 1. the to address is not a contract
        // 2. to address is valid receiver
        require(
            to.code.length == 0 ||
                IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) ==
                IERC721Receiver.onERC721Received.selector,
            "unsafe recepient"
        );
    }

    // Mint a token
    function _mint(address to, uint256 tokenId) internal {
        // Check if the to address is zero
        require(to != address(0), "mint to zero address");

        // Check if the token id is unique (not belong to anyone)
        require(_ownerOf[tokenId] == address(0), "token already exists");

        _balanceOf[to]++;
        _ownerOf[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }

    // Destroy a token
    function _burn(uint256 tokenId) internal {
        address owner = _ownerOf[tokenId];

        // token does not exist
        require(owner != address(0), "token doesn't exist");

        _balanceOf[owner] -= 1;

        delete _ownerOf[tokenId];
        delete _approvals[tokenId];

        emit Transfer(owner, address(0), tokenId);
    }
}

contract MyNFT is ERC721 {
    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function burn(uint256 tokenId) external {
        // only the owner can burn a token
        require(msg.sender == _ownerOf[tokenId], "not owner");
        _burn(tokenId);
    }
}
