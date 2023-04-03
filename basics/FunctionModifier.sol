// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title FunctionModifier - reuse code before and / or after function
contract FunctionModifier {
    bool public paused;
    uint256 public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    /// @notice modifier for validating if its paused
    modifier whenNotPaused() {
        require(!paused, "paused");
        _; //  execute the rest of the code
    }

    // modifier is added
    function inc() external whenNotPaused {
        count++;
    }

    /// modifier is added
    function dec() external whenNotPaused {
        count--;
    }

    /// @notice modifier for validiating the input
    modifier cap(uint256 _x) {
        require(_x < 100, "input must less than 100");
        _;
    }

    // add both two modifiers for validation
    function incBy(uint256 _x) external whenNotPaused cap(_x) {
        count += _x;
    }

    /// @notice a modifier executes code before and after a function
    modifier sandwich() {
        count += 10; // execute before the function call
        _;
        count *= 2; // execute after the function call
    }

    function foo() external sandwich {
        count++; // What's the expected value?
    }
}
