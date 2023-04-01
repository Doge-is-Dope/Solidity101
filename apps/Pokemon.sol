// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Pokemon {
    // uint256 a = 10;
    // event Log(address indexed sender, string message);

    // event Log2(address indexed sender, string indexed message);

    // function test(string memory text) public {
    //     emit Log(msg.sender, "Hello EVM!");

    //     emit Log2(msg.sender, text);
    // }

    struct PokemonItem {
        string name;
        uint256 atk;
        uint256 def;
    }

    mapping(address => PokemonItem[]) public ownerToPokemons;

    function create(
        string memory _name,
        uint256 _atk,
        uint256 _def
    ) external returns (PokemonItem memory p) {
        p = PokemonItem(_name, _atk, _def);
        PokemonItem[] storage list = ownerToPokemons[msg.sender];
        list.push(p);
    }

    function increaseAtk(uint _index) external payable {
        require(msg.value == 0.1 ether);
        PokemonItem storage p = ownerToPokemons[msg.sender][_index];
        p.atk++;
        p.def++;
    }
}
