// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Constructor {
    address public owner;
    uint public x;

    // Inititialize the state variables with contructor
    constructor(uint _x) {
        owner = msg.sender;
        x = _x;
    }
}