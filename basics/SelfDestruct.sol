// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @notice destroy the contract
/// - delete a contract
/// - force send Ether to any address
contract SelfDestruct {
    // Deploy the contract with some ethers
    constructor() payable {}

    // Send the balance to the function caller
    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint256) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // This will call the selfdestruct in kill() to send all ethers to this contract
    function kill(SelfDestruct _sd) external {
        _sd.kill();
    }
}
