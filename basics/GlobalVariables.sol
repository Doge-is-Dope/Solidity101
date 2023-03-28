// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract GlobalVariables {
    // blockchain, transaction, account infomration
    function getGlobalVars() external view returns (address, uint256, uint256) {
        address sender = msg.sender;
        uint256 timestamp = block.timestamp;
        uint256 blockNum = block.number;
        return (sender, timestamp, blockNum);
    }
}
