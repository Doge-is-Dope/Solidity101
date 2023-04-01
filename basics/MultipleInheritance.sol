// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
The inheritace order shall be from most base like

    A
   / \
  B   C
  |   |
  |   D
  \  /
    E

inheritance order: A B C D E
*/
contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    // B will have this function
    function test() public pure returns (string memory) {
        return "A";
    }
}

contract B is A {
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }

    function bar() public pure virtual override returns (string memory) {
        return "B";
    }
}

// The inheritance order is from the most base like
// It'll cause comiple error if the order is incorrect
contract C is A, B {
    // The order of the override parameter is not important
    function foo() public pure override(B, A) returns (string memory) {
        return "C";
    }

    function bar() public pure override(A, B) returns (string memory) {
        return "C";
    }
}
