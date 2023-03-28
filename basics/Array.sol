// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Array {
    uint256[] public nums = [1, 2, 3];
    uint256[3] public fixedNums = [4, 5, 6];

    function example() external {
        nums.push(4); // nums: [1, 2, 3, 4]
        
        uint x = nums[1]; // x: 2
        
        nums[2] = 777; // nums: [1, 2, 777, 4]
        
        delete nums[1]; // nums: [1, 0, 777, 4]

        nums.pop(); // nums: [1, 0, 777]

        uint len = nums.length; // x: 3
    }


    function createArrayInMemory() external pure {
        // create array in memory, only fixed size can be created
        uint[] memory a = new uint[](5);
        a[1] = 3;
    }

    function returnArray() external view returns(uint[] memory) {
        return nums;
    }
}
