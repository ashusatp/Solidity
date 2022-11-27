// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract loops{

    uint[3] public whileArr;
    uint[3] public forArr;

    function whileLoop() public{
        if(whileArr.length == 0){
            uint count;
            while(count<whileArr.length){
                whileArr[count] = count+1;
                count++;
            }
        }else{
            return;
        }
    }

    function forLoop() public{
        if(forArr.length == 0){
            for(uint i=0; i<forArr.length; i++ ){
                forArr[i] = i+1;
            }
        }else{
            return;
        }
    }

    function ternaryOperation(uint _num) public pure returns (bool){
        return _num>0 ? true: false;
    }

}