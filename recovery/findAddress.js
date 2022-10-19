const { ethers } = require("hardhat");

describe("create address",function(){
    const addr = "0xEC404653bfFA652c55D88DFaE2339fB39b5395bd";
    const nonce = "0x01";
    const rlpEncoded = ethers.utils.RLP.encode([addr, nonce]);
    const contractAddress = ethers.utils.keccak256(rlpEncoded);
    console.log("created contract adddress :",`0x${contractAddress.slice(26)}`);
});


