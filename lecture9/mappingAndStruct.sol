// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

struct donor{
    string name;
    uint age;
    string add;
    uint don;
}

contract advMapping{
    mapping(address=>donor) public acc_info;

    function set(string memory _name, uint _age, string memory _address, uint _donate) public{
        acc_info[msg.sender] = donor(_name,_age,_address,acc_info[msg.sender].don+_donate);
        // msg.sender is a adress of that id which has been executed this transaction.
    }

    function deleteInfo() public{
        delete acc_info[msg.sender];
    }

}
