// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    // Get the total amount of the token
    function totalSupply() external view returns (uint256);

    // Get the [balance] of the [account]
    function balanceOf(address account) external view returns (uint256 balance);

    // Transfer [amount] of tokens from [msg.sender] to [recipient]
    function transfer(address recipient, uint256 amount)
        external
        returns (bool success);

    // Get [remaining] tokens can be used by [spender] authorized by [owner]
    function allowance(address owner, address spender)
        external
        view
        returns (uint256 remaining);

    // [msg.sender] approves [amount] of tokens can be used by [spender]
    function approve(address spender, uint256 amount)
        external
        returns (bool success);

    // Transfer [amount] of tokens from [sender] to [recipient]
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 tokens);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 tokens
    );
}
