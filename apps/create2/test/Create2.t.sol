// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Create2.sol";

contract CounterTest is Test {
    Factory _factory;
    address _owner;
    uint256 constant _foo = 123;
    bytes32 constant _salt = "salt";

    function setUp() public {
        _factory = new Factory();
        _owner = makeAddr("owner");
    }

    function testPrecalculatedAddress() public {
        address preCal = _factory.calculateAddr(_owner, _foo, _salt);
        console.log("preCal", preCal);
        address res = _factory.deploy(_owner, _foo, _salt);
        assertEq(res, preCal);
    }
}
