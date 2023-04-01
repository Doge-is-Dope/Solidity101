// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/* 2 ways calling parent functions:
 - direct
 - super

Graph of inheritance:
    A
   / \
  B   C
   \ /
    D
 */

contract A {
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo");
    }

    function bar() public virtual {
        emit Log("A.bar");
    }
}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo");
        A.foo(); // call a function directly from the parent
    }

    function bar() public virtual override {
        emit Log("B.bar");
        super.bar(); // call a function using super from the parent
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo");
        A.foo(); // call a function directly from the parent
    }

    function bar() public virtual override {
        emit Log("C.bar");
        super.bar(); // call a function using super from the parent
        // the order of execution: C -> A
    }
}


contract D is B, C {
    // Required to override all parent functions
    function foo() public virtual override(B, C) {
        B.foo(); // call specific parent function
        // the order of execution: B -> A
    }

    function bar() public virtual override(B, C) {
        super.bar(); // call all parents' functions
        // the order of execution: C -> B -> A
    }
}

contract E is A, B {
    function foo() public virtual override(A, B) {
        super.foo(); // call specific parent function
        // the order of execution: B -> A
    }

    function bar() public virtual override(A, B) {
        super.bar(); // call all parents' functions
        // the order of execution: B -> A
    }
}
