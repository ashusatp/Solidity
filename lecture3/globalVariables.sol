// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract globalVariables{ // predefined variables

   address public myadd = msg.sender;
   uint public time = block.timestamp;
   uint public diff = block.difficulty;
   uint public gascost = tx.gasprice;
   address public senderOfOrigin = tx.origin;
   uint public weiValue = msg.value; 
}
