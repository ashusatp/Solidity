// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract bytesArray {
    // 1 byte = 8 bits  and 1 byte = 2 hexadecimal digts   and 1 hexa deciamal = 4 bits

    bytes3 public b3; // 3 bytes --> 6 hx digits
    bytes2 public b2; // 2 bytes --> 4 hx digits
    bytes2 public b22; // 2 bytes --> 4 hx digits

    function setter() public {
        b3 = "abc";
        b2 = "ab";
        b22 = "a";
    }

    // DYNAMIC
    bytes public dynamicByteArray;

    function dypush() public {
        dynamicByteArray.push("a");
    }

    function getdyElement(uint256 _i) public view returns (bytes1) {
        return dynamicByteArray[_i];
    }

    function getDyLength() public view returns (uint256) {
        return dynamicByteArray.length;
    }
}
