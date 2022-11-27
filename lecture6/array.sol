// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract array {
    // predefined variables
    uint256[4] public fixedArray = [1, 2, 3, 4];

    function setter(uint256 _index, uint256 _value) public {
        fixedArray[_index] = _value;
    }

    uint256[] public dynamicArray;

    // push element inside the dynamic array
    function pushElement(uint256 _item) public {
        dynamicArray.push(_item);
    }

    // get the length of the dynamic array
    function len() public view returns (uint256) {
        return dynamicArray.length;
    }

    // pop element from dynamic array
    function popElement() public {
        dynamicArray.pop();
    }
}
