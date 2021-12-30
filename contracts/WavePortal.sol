
pragma solidity ^0.8.0;

// SPDX-License-Identifier: UNLICENSED

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) waves;

    constructor() {
        console.log("Yo, yo I am a contract");
    }

    function wave() public {
        totalWaves += 1;
        waves[msg.sender] = totalWaves;
        
        console.log("%s has waved!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}