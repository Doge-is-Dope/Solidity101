// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

/// @title example of a prod app to check the ownership of a contract using following features
/// - state variables
/// - function modifier
/// - function
/// - error handling
contract Ownable {
    address public owner;

    // Set the owner when the contract is deployed
    constructor() {
        owner = msg.sender;
    }

    // The modifier to validate if the caller is the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can perform this operation");
        _; // execute the rest of the code
    }

    /// @dev set the new owner
    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0x0), "invalid address");
        owner = _newOwner;
    }

    /// @dev only the owner can call this function
    function onlyOwnerCanCallThisFunc() external onlyOwner {}

    /// @dev anyone can call this function
    function anyoneCanCallThisFunc() external {}
}
