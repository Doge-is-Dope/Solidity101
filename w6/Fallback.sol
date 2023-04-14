// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Fallback {
    event Log(string func, address sender, uint256 value, bytes data);

    // fallback will be executed when
    // - function does not exist
    // - ether is directly sent to the contract but receive() does not exist or msg.data is empty
    // By making fallback() payable, it can receive ether
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    // receive() will be executed when msg.data is empty and receive() exists
    receive() external payable {
        // msg.data is empty in receive()
        emit Log("receive", msg.sender, msg.value, "");
    }
}
