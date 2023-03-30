// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Data locations - storage, memory, calldata
// storage: For state variables. Used for dynamic data to be updated and saved
// memory: load data on memory. Used to read data or modify data without saving it on blockchain
// calldata: like memory, but can only used for function inputs. It's unmodifiable but it saves gas when the input is passed to another function!
contract DataLocations {
    struct Book {
        uint256 no;
        string title;
    }

    // A map of the author to book
    mapping(address => Book) public authorToBook;

    function example() external returns (Book memory) {
        authorToBook[msg.sender] = Book({no: 123, title: "ABC"});

        // point to the storage, i.e. state variable
        Book storage myBook = authorToBook[msg.sender];
        myBook.title = "DEF";

        // Get Book to memory. When the function is done exexuting, the changes will not be saved
        Book memory readOnly = authorToBook[msg.sender];
        readOnly.no = 456;

        return readOnly;
    }

    // Function inputs also need data locations
    function examples2(uint256[] calldata arr)
        external
        pure
        returns (uint256[] memory)
    {
        // For arrays initialized on memory can only be 'fixed' array
        uint256[] memory memArr = new uint256[](5);
        memArr[0] = 123;

        // since the input of this function is located at calldata, it will not copy as a new array;
        // If _internalExample's arr is atw memory, it will create a copy and load into memory.
        // That's the reason calldata saves gas!
        _internalExample(arr);

        return memArr;
    }

    function _internalExample(uint256[] calldata arr) private pure {
        uint256 x = arr[0];
        x++;
    }
}
