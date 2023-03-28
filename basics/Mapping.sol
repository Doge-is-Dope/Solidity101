// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Mapping {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => bool)) public isFriend; // nested mapping

    function examples() external returns (uint256, uint256) {
        balances[msg.sender] = 123;
        uint256 bal1 = balances[msg.sender]; // bal1: 123
        uint256 bal2 = balances[address(1)]; // bal2: 0 ; because the default of uint is zero

        balances[msg.sender] += 456; // balances[msg.sender]: 579; get the value and update it

        delete balances[msg.sender]; // reset to default value

        isFriend[msg.sender][address(this)] = true; // "this" means the contract

        return (bal1, bal2);
    }
}
