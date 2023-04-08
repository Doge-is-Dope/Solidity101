// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Ownable.sol";

contract Todo is Ownable {
    struct Task {
        string name;
        bool completed;
    }

    mapping(address => Task[]) listOf;

    /// @notice Create a task and add it to the list
    function create(string calldata _name) external {
        // Add a new task to the caller's list
        listOf[msg.sender].push(Task(_name, false));
    }

    // @notice Update a task's completeness
    function update(uint256 _index) external {
        // Get the caller's list
        Task[] storage todoList = listOf[msg.sender];
        // Update the task by index
        todoList[_index].completed = !todoList[_index].completed;
    }

    // @notice Retrieve a task by specified index
    function get(uint256 _index) external view returns (Task memory task) {
        // Get the list by caller, and get the task by index
        task = listOf[msg.sender][_index];
    }

    // @notice Detroy the contract
    function kill() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }
}
