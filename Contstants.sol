// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Constants {
    // Gas cost: 356
    address public constant MY_ADDRESS =
        0x91a68Df374fc3Feec5c8F8FD4F6b1209247A5445;
    uint256 public constant MY_NUM = 123;
}

// variables cost more gas
contract Vars {
    // Gas cost: 2489
    address public MY_ADDRESS = 0x91a68Df374fc3Feec5c8F8FD4F6b1209247A5445;
}
