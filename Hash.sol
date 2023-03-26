// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Hash {
    function hash(string memory text, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    function encode(string memory text0, string memory text1) external pure returns(bytes memory) {
        return abi.encode(text0, text1);
    }

    function encodePacked(string memory text0, string memory text1) external pure returns(bytes memory) {
        return abi.encodePacked(text0, text1);
    }

    // if the input is dynamic, there may be collision using 'encodePacked'
    // encodePacked(AAA, BBB) -> AAABBB
    // encodePacked(AA, ABBB) -> AAABBB
    function collision(string memory text0, string memory text1) external pure returns(bytes32) {
        return keccak256(abi.encodePacked(text0, text1));
    } 
}

contract GuessTheMagicWord {
    bytes32 public answer =
        0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00;

    // Magic word is "Solidity"
    function guess(string memory _word) public view returns (bool) {
        return keccak256(abi.encodePacked(_word)) == answer;
    }
}