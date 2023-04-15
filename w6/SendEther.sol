// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
There are 3 ways to send ether
1. transfer - 2300 gas revert
2. send - 2300 gas returns bool
3. call - all gas  returns bool & data 
*/
contract SendEther {
    // Allow the contact to receive ether
    constructor() payable {}

    // Another way to allow the contact to receive ether
    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123); // use 2300 gas
    }

    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(123); // use 2300 gas
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 123}(""); // use full gas
        require(success, "send failed");
    }
}

contract EthReceiver {
    event Log(uint256 amount, uint256 gas);

    // transfer: 2260 gas left
    // send: 2260 gas left
    // call: 6521 gas left
    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
