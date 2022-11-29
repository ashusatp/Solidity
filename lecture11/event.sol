// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Event{
    event balance(address account, string message, uint val);

    function setData() public{
        emit balance(msg.sender,"has value", msg.sender.balance);
    }
}

contract chatApp{
    event chat(address _from, address _to, string _message);

    function sendMes(address to_, string memory message_) public{
        emit chat(msg.sender,to_,message_);
    }
}