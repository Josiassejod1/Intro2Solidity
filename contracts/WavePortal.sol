
pragma solidity ^0.8.0;

// SPDX-License-Identifier: UNLICENSED

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    uint256 private seed;

    mapping(address => uint256) public lastWavedAt;

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    constructor() payable {
        console.log("Yo, yo I am a contract");
        seed = (block.timestamp + block.difficulty) % 100;
    }



    event NewWave(address indexed from, uint256 timestamp, string message);

    Wave[] waves;
   

    function wave(string memory _message) public {

        require(
            lastWavedAt[msg.sender] + 1 minutes < block.timestamp,
            "Wait 1m"
        );

        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves += 1;
        
        console.log("%s has waved w/ message!", msg.sender, _message);

         waves.push(Wave(msg.sender, _message, block.timestamp));   

         seed = (block.difficulty + block.timestamp + seed) % 100;
         console.log("Random # generated: %d", seed);

         if (seed <= 50) {
              
            uint256 prizeAmount = 0.0001 ether;
        
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money"
            );

            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdrawal funds");
            
            }

            emit NewWave(msg.sender, block.timestamp, _message);
           
        }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }
}