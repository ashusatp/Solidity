// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract viewPureSimple{ // predefined variables
    //view --> only read variables
    //pure --> neither read nor write the variable
    //simple --> change stateVariables

    uint public age = 20;

    function viewFunc() public view returns(uint){
        return age;
    }
    function viewFunc2() public view returns(uint){
        return age+10;
    }

    function pureFunc1() public pure returns(uint){
        return 1;
    }

    function pureFunc2(uint _x) public pure returns(uint){
        return _x;
    }

    function simplefun() public{
        age = age+10;
    }
}
