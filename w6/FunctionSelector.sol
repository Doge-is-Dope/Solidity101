// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FunctionSelector {
    // Get the function selector
    // 1. Cast function signature string to bytes
    // 2. Hash the bytes with Keccak256
    // 3. Extract the first 4 bytes
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }

    // function getSelectorByEncode(
    //     string calldata _func,
    //     address _address,
    //     uint256 _amount
    // ) external pure returns (bytes4) {
    //     return bytes4(abi.encodeWithSignature(_func, _address, _amount));
    // }
}

contract Receiver {
    event Log(bytes data);

    // Log the data
    // - _to: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // - _amount: 11
    function transfer(address _to, uint256 _amount) external {
        emit Log(msg.data);
        // data:
        // 0xa9059cbb -> function to be called (4 bytes) namely function selector
        // 0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4 -> first input - _to
        // 000000000000000000000000000000000000000000000000000000000000000b -> second input - _amount
    }
}
