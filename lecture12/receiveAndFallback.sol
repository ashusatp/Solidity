// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/*fallback
It is executed when a non-existent function is called on the contract.
It is required to be marked external.
It has no name.
It has no arguments
It can not return any thing.
It can be defined one per contract.
If not marked payable, it will throw exception if contract receives ether.
It's main use is to directly send the ETH to contract
*/

contract fallback_receive{

    event log(string fun, address sender, uint val, bytes _data);

    fallback() external payable{
        emit log("fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable{
        emit log("receive", msg.sender, msg.value, "");
    }

    function checkBalance() public payable returns(uint){
        return address(this).balance;
    }
}