// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract auctionSmartContract{
    address payable public auctioneer;
    uint public startTimeBlock; //start time
    uint public endTimeBlock;   //end time

    enum auctionStates {
        Started,
        Running,
        Ended,
        Cancelled
    }
    auctionStates public auctionState;

    uint public highestBid;
    uint public highestPayableBid;
    uint public bidIncrement;

    address payable public highestBidder;
    mapping(address=>uint) public bids;

    constructor(){
        auctioneer = payable(msg.sender);
        auctionState = auctionStates.Running;
        startTimeBlock = block.number;
        endTimeBlock = startTimeBlock + 240;
        bidIncrement = 1 ether;
    }



    modifier notOwner(){
        require(msg.sender != auctioneer, "Owner cannot bid");
        _;
    }
    modifier Owner(){
        require(msg.sender == auctioneer);
        _;
    }
    modifier statrted(){
        require(block.number>startTimeBlock);
        _;
    }
    modifier beforeEnding(){
        require(block.number<endTimeBlock);
        _;
    }

    //cancle the auction
    function cancleAuction() public Owner{
        auctionState = auctionStates.Cancelled;
    }
    //endAuction
    function endAuction() public Owner{
        auctionState = auctionStates.Ended;
    }

    function min(uint num1, uint num2) private pure returns(uint){
        if(num1>num2){
            return num2;
        }else{
            return num1;
        }
    }
    function bid() public payable notOwner statrted beforeEnding{
        require(auctionState == auctionStates.Running);
        require(msg.value>= 1 ether);
        uint currentBid = bids[msg.sender] + msg.value;
        require(currentBid>highestPayableBid);
        bids[msg.sender] = currentBid;
        if(currentBid<bids[highestBidder]){
            highestPayableBid = min(currentBid+bidIncrement,bids[highestBidder]);
        }else{
            highestPayableBid = min(currentBid,bids[highestBidder]+bidIncrement);
            highestBidder = payable(msg.sender);
        }
    }

    function finalizeAuction() public{
        require(auctionState == auctionStates.Cancelled ||auctionState == auctionStates.Ended|| block.number > endTimeBlock);
        require(msg.sender == auctioneer || bids[msg.sender] > 0);

        address payable person;
        uint value;

        if(auctionState == auctionStates.Cancelled){
            person = payable(msg.sender);
            value = bids[msg.sender];
        }else{
            if(msg.sender == auctioneer){
                person = auctioneer;
                value = highestPayableBid;
            }else{
                if(msg.sender == highestBidder){
                    person = highestBidder;
                    value = bids[highestBidder]-highestPayableBid;
                }else{
                    person = payable(msg.sender);
                    value = bids[msg.sender];
                }
            }
        }
        bids[msg.sender] = 0;
        person.transfer(value);
    }

}