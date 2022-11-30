// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract revertAndAssert{

    uint age =1;
    error throwError(string,address);

    function checkRevert() public{
        age = age+5;

        if(age<5){
            revert throwError("msggg",msg.sender);
        }
    }
} 