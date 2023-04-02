// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract A {
    // Directly call the function
    function test() external view returns (address, address) {
        return (tx.origin, msg.sender); // shall be the same
    }
}

contract B {
    // Call the function directly
    function test() external view returns (address, address) {
        return (tx.origin, msg.sender); // shall be the same
    }

    // Call the function in contract A by passing the address
    function callA(address _ca) external view returns (address, address) {
        // A a = A(_ca);
        // return a.test();
        return A(_ca).test(); // tx.origin: eoa, msg.sender: contract B
    }
}
