
pragma solidity ^0.8.0;

// SPDX-License-Identifier: UNLICENSED

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    constructor() payable {
        console.log("Yo, yo I am a contract");
    }



    event NewWave(address indexed from, uint256 timestamp, string message);

    Wave[] waves;
   

    function wave(string memory _message) public {
        totalWaves += 1;
        
        console.log("%s has waved w/ message!", msg.sender, _message);

         emit NewWave(msg.sender, block.timestamp, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));
        
        uint256 prizeAmount = 0.0001 ether;
        
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money"
        );

        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdrawal funds");

       
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }
}