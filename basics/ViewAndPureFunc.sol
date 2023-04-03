// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Example {
    uint256 num;

    /// @notice view - does not UPDATE the state
    /// @return timestamp of the current block in seconds since the epoch
    function viewFunc() external view returns (uint256) {
        return block.timestamp;
    }

    /// @notice pure - does not UPDATE the state nor READ the state (including state vars & global vars)
    /// @notice num of a arbitrary value
    function pureFunc() external pure returns (uint256) {
        return 100;
    }

    /// @notice this is a 'view' function since it reads 'num' from the contract
    function addToNum(uint256 _x) external view returns (uint256) {
        return num + _x;
    }

    /// @notice this is a 'pure' function since it does not read anything from the contract
    function addTwoNums(uint256 _x, uint256 _y)
        external
        pure
        returns (uint256)
    {
        return _x + _y;
    }

    /// @notice this is not a 'view' nor a 'pure' function since it updates the value in the contract
    function addToNumAndUpdate(uint256 _x) external returns (uint256) {
        return num += _x;
    }
}
