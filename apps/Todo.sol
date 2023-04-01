// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Todo {
    struct Item {
        address creater;
        string title;
        bool isDone;
    }

    Item[] todoList;

    constructor() {
        todoList.push(Item(msg.sender, "First item", false));
    }

    // Retrieve a item by index
    function getItem(uint _index) external view returns(Item memory item) {
        item = todoList[_index];
    }

    // Add a item to the list
    function addItem(Item calldata _item) external {
        todoList.push(_item);
    }

    // Toggle a item's completeness
    function toggleItem(uint _index) external {
        Item storage item = todoList[_index];
        item.isDone = !item.isDone;
    }
}
