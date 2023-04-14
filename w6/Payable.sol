// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Payable {
    // payable address can be used to send ether
    address payable public owner;

    constructor() {
        // msg.sender is an address type so it has to cast to payable address
        owner = payable(msg.sender);
    }

    // payable function can be used to receive ether
    function deposit() external payable {}

    // Get the balance stored in the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Withdraw all ethers from the contract to the owner
    function withdraw() external {
        // Get the balance first
        uint256 amount = getBalance();

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }
}
