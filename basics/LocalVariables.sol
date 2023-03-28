// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract LocalVariables {
    // state variables
    address public addr;

    function foo() public {
        // local variables
        uint x = 123;
        bool y = false;
        x += 456;
        y = true;

        // Update a state variable
        addr = address(1);
    }
}