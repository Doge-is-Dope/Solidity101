// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Loop {
    function example() external pure {
        for (uint256 i = 0; i < 10; i++) {
            // some code here

            if (i == 3) {
                // 'continue' skips the current iteration.
                continue;
            }

            if (i == 5) {
                // 'break' exits the loop. i.e. stop from 5
                break;
            }
        }

        // infinite loop is not suggested
        // while(true) { }

        uint256 j = 0;
        // stop the loop when j is 10
        while (j < 10) {
            j++;
        }
    }

    /// @notice sum up the numbers from 1 to n
    /// @return sum
    function accumulate(uint256 _n) external pure returns (uint256) {
        uint256 res;
        for (uint256 i = 1; i <= _n; i++) {
            res += i;
        }
        return res;
    }
}
