// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Enum {

    // The first value in a enum is the default value, i.e. 'None'
    enum Status {
        None, // 0
        Pending, // 1
        Shipped, // 2
        Completed, // 3
        Rejected, // 4
        Canceled // 5
    }

    // default visibility is 'internal'
    Status status;

    function get() view external returns(Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    // Set a enum value
    function ship() external {
        status = Status.Shipped;
    }


    function reset() external {
        // this will reset the enum to the default value which is the first value
        delete status;
    }
}