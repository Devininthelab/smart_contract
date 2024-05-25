// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";
// is for inheritance
contract ExtraStorage is SimpleStorage{
    // overriding the store function
    function store(uint256 _favouriteNumber) public override {
        favoriteNumber = _favouriteNumber + 5;
    }
}