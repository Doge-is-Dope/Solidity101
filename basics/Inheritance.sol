// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// `is` is for inheritance
// `virtual` is for letting the function overridable while `override` is for overriding the parent's function
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
    function foo() public pure override returns (string memory) {
        return "B";
    }

    // 'virtual' is for letting child override the function
    // 'override' is for overriding parent's function
    function bar() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is B {
     function bar() public pure override returns (string memory) {
        return "C";
    }
}
