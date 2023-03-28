// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract FunctionOutputs {
    function returnMany() public pure returns (uint256, bool) {
        return (1, true);
    }

    function returnNamed() public pure returns (uint256 u, bool b) {
        return (1, true);
    }

    // This will save gas because it doesn't copy the value
    function returnAssigned() public pure returns (uint256 u, bool b) {
        u = 1;
        b = true;
    }

    function getValues() external pure {
        (uint256 _u, bool _a) = returnMany();
        (, bool _b) = returnMany(); // omit the first return
    }
}
