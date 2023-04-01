// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Define the interface of Counter without knowing the code
interface ICounter{
    function count() external view returns(uint);
    function inc() external;
}


contract CallInterface {

    uint public count;
    
    // the original contract address is required for calling functions
    function examples(address _counter) external {
        // Call a function within the same file
        // Counter(_counter).inc();

        // Call a function without knowing the code
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}
