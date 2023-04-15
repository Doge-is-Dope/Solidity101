// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SaveGas {
    // access to memory is cheaper than storage
    function foo() external {
        // uint someStorageData;
        // bytes memory someMemoryData;
    }

    uint256 private  n = 5000; // cost more when n is large

    // Cost 4886 gas
    function noCache() external view returns (uint256) {
        uint256 s = 0;
        // this loop will access 'n' 5 times
        for (uint256 i = 0; i < n; i++) {
            s += 1;
        }
        return s;
    }

    // Cost 4355 gas
    function cache() external view returns (uint256) {
        uint256 s = 0;
        uint256 _n = n; // cache storage data to memory
        for (uint256 i = 0; i < _n; i++) {
            s += 1;
        }
        return s;
    }
}

//    n |  no cache |   cache
//   10 |    7224   |    6193
//  100 |   49704   |   39673
// 1000 |  474504   |  374473
// 5000 | 2362504   | 1862473