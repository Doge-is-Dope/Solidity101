// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DefaultValues {
    bool public b; // false
    uint public u; // 0
    int public i; // 0
    address public addr; // 0x..0 (40 zeros)
    bytes32 public b32; //  0x..0 (64 zeros)
}