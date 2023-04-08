// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Ownable control
contract Ownable {
    address public owner;

    /// @dev Set the owner when the contract is deployed
    constructor() {
        owner = msg.sender;
    }

    /// @dev The modifier to validate if the caller is the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can perform this operation");
        _; // execute the rest of the code
    }

    /// @dev set the new owner
    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0x0), "invalid address");
        owner = _newOwner;
    }
}
