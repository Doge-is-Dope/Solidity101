// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// You can throw an error by calling require, revert or assert.

contract Errors {
    // require is used to validate inputs and conditions before execution.
    function testRequire(uint256 _x) external pure {
        require(_x <= 10, "The input must lower than 10.");
    }

    // revert is useful when the condition to check is complex.
    function testRevert(uint256 _x) external pure {
        if (_x > 10) {
            revert("The input must lower than 10.");
        }
    }

    uint256 public a = 123;

    // assert is only used for internal errors. e.g. state variables
    function testAssert() external view {
        // Check if the state variable has been updated
        assert(a == 123);
    }

    // Assume accidentally updated a
    function updateA(uint256 _a) external {
        a = _a;
    }

    function errorRevert(uint256 _x) external {
        a = _x;
        require(_x < 10); // If the error is thrown, the state will be undone
    }

    error MyError(address caller, uint256 i);
    // Custom error can only be used with 'revert'
    function testCustomError(uint256 _x) external view {
        if (_x > 10) {
            revert MyError(msg.sender, _x);
        }
    }
}
