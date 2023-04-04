// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @notice can not be initialized until the contract is deployed
/// this also savesome gas
contract Immutable {
    // gas: 45654
    // address public owner = msg.sender;

    // gas: 22457
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    uint256 public x;

    function foo() external {
        require(owner == msg.sender);
        x++;
    }
}
