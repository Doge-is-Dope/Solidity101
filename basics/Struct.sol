// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Struct {
    struct Car {
        string model;
        uint256 year;
        address owner;
    }

    Car[] public cars;

    function examples() external {
        // Init a struct like a function
        Car memory toyota = Car("Toyota", 2000, msg.sender);

        // Init a struct by a key-value pair
        Car memory lambo = Car({
            year: 2001,
            model: "Lanborghini",
            owner: msg.sender
        });

        // Init a empty struct and then update it
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2002;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        // Add a struct right after init it
        cars.push(Car("Ferrari", 2020, msg.sender));


        // 'storage' is required to update a value
        Car storage car1 = cars[0];
        car1.year = 1999; // update a value
        delete car1.owner; // reset to default value

        delete cars[1]; // reset all values in a struct
    }
}
