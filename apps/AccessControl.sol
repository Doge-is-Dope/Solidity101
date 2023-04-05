// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title a example of setting a role to an account
contract AccessControl {
    // 'indexed' is for quick filtering in logs
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    // role -> account -> bool
    // the name of the role is hashed to 32 bytes to save gas
    mapping(bytes32 => mapping(address => bool)) public roles;

    // 'private' and 'constant' save gas
    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    constructor() {
        // Grant the contract creator admin role
        _grantRole(ADMIN, msg.sender);
    }

    // check if the given role of the caller is authorized
    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "Not authorized");
        _;
    }

    // marked as internal for child contract
    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    // the external version of _grantRole
    // Grant the specified role to the account
    function grantRole(bytes32 _role, address _account)
        external
        onlyRole(ADMIN)
    {
        _grantRole(_role, _account);
    }

    // Revoke the specified role to the account
    function reovokeRole(bytes32 _role, address _account)
        external
        onlyRole(ADMIN)
    {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }
}
