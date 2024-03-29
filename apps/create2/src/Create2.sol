// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Factory {
    // Returns the address of the newly deployed contract
    function deploy(address _owner, uint256 _foo, bytes32 _salt) public payable returns (address) {
        // This syntax is a newer way to invoke create2 without assembly, you just need to pass salt
        // https://docs.soliditylang.org/en/latest/control-structures.html#salted-contract-creations-create2
        return address(new TestContract{salt: _salt}(_owner, _foo));
    }

    function _getBytecode(address _owner, uint256 _foo) private pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_owner, _foo));
    }

    // hash("0xFF", deployer_address, salt, bytecode)
    function calculateAddr(address _owner, uint256 _foo, bytes32 _salt) public view returns (address) {
        bytes memory bytecode = _getBytecode(_owner, _foo);
        return address(
            uint160(uint256(keccak256(abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode)))))
        );
    }
}

contract TestContract {
    address public owner;
    uint256 public foo;

    constructor(address _owner, uint256 _foo) payable {
        owner = _owner;
        foo = _foo;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
