// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;
/*
>=0.8.7 <0.9.0 -> means >= 0.8.7 and < ...
0.8.12; ^ means version above also ok
*/

// contract can be understand as class
contract SimpleStorage{
    // boolean, uint, int, address, bytes
    /*bool hasFavouriteNumber = true;
    uint256 favouriteNumber = 5;
    string favouriteNumberInText = "Five";
    int256 favouriteInt = -5;
    address myAddress = 0x78E4b4fDa8A0a0D11d03f74514DbF3B3761ef8D9;
    bytes32 favouriteBytes = "cat";*/


    //This gets intialized to zero
    uint256 favouriteNumber;
    //People public person = People({favouriteNumber: 2, name:"Devin"});

    // can be understand as dictionary
    mapping(string => uint256) public  nameToFavouriteNumber;

    struct People{
        uint256 favouriteNumber;
        string name;
    }

    //uint256[] public favouriteNumberList;
    People[] public people;

    function store(uint256 _favouriteNumber) public{
        favouriteNumber = _favouriteNumber;
        favouriteNumber =  favouriteNumber + 1;
    }
    // 0xf8e81D47203A594245E36C48e151709F0C19fBe8

    // view, pure -> does not require gas as we only read from
    // the blockchain. consume gas when modify the state of the blockchain
    function retrieve() public view returns(uint256){
        return favouriteNumber;
    }

    // the keywork memory in _name only because it stores the reference
    function addPerson(string memory _name, uint256 _favouriteNumber) public{
        people.push(People(_favouriteNumber, _name));

        // way 2
        // People memory newPerson = People({favouriteNumber: _favouriteNumber, name: _name});
        // people.push(newPerson);

        nameToFavouriteNumber[_name] = _favouriteNumber;
    }
}