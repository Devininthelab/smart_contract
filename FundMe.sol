// Get funds from users
// withdraw funds
// Set a minimum funding

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe{
    //uint256 public number;
    uint256 public minimumUsd = 50 * 1e18;
    using PriceConverter for uint256;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        // want to be able to set a minimum fund account
        // 1. How do we send ETH to this contract
        //number = 5;
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough"); 

        // what is reverting
        // undo any action before, and send remaining gas back (if the condition isn't met)
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function getPrice() public view returns(uint256){
        // ABI: 
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price, , , ) = priceFeed.latestRoundData();

        //ETH in terms of USD
        return uint256(price * 1e10);
    }



    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function withdraw() public onlyOwner{
        //require(msg.sender == owner, "Sender is not owner");
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        //reset the array
        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Sender is not owner");
        _;
    }
}