// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// Use determined arguments to construct parents
contract U is S("hello"), T("world") {

}

// Use dynamic arguments to construct parents
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

// Combie both determined and dynamic args to construct parents
contract W is S("hello"), T {
    constructor(string memory _text) T(_text) {}
}

// The order of initializing parents is determined by the order declared in the first line
// Order of execution:
// 1. S
// 2. T
// 3. Test
contract Test is S, T {
    constructor(string memory _name, string memory _text) T(_text) S(_name)  {}
}
