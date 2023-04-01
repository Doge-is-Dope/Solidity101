// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// library can not have state variables
// if all functions are internal, the library does not require deployment
// If any function is not internal, the library is required to deploy
library Math {
    function max(uint256 x, uint256 y) internal pure returns (uint256) {
        return x >= y ? x : y;
    }
}

library ArrayLib {
    function find(uint256[] storage arr, uint256 x)
        internal
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        // throw an error if the value is not in the array
        revert("not found");
    }
}

contract Test {
    function testMax(uint256 _x, uint256 _y) external pure returns (uint256) {
        return Math.max(_x, _y);
    }

    // using [Library] for [DataType];
    using ArrayLib for uint256[]; // to use uint[].find, use `using`...`for` 

    uint256[] testArray = [1, 2, 3];

    function testFind() external view returns (uint256 i) {
        // i = ArrayLib.find(testArray, 2);
        i = testArray.find(2); // using...for
    }
}
