// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract stateVariables{ // variables defined inside the contract but outside of functions

    uint public salary;

    constructor(){
        salary = 1000;
    }

    function setSalary() public {
        salary = 2000;
    }
    
}
