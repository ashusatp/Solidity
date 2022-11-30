// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract fund{
    uint public target;
    uint public minimumContribution;
    address public manager;
    uint public deadLine;
    uint public totalContributors;
    uint public totalFund;
    mapping(address=>uint) public contributors;

    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=>bool) voters;
    }

    mapping(uint=>Request) public requests;
    uint public numRequests;

    constructor(uint _target, uint _deadline){
        manager = msg.sender;
        target = _target;
        minimumContribution = 100 wei;
        deadLine = block.timestamp + _deadline;
    }

    modifier onlyManager(){
        require(msg.sender == manager);
        _;
    }

    modifier notManager(){
        require(msg.sender == manager);
        _;
    }

    function sendFund() public payable notManager{
        require(block.timestamp <= deadLine, "Time is over");
        require(msg.value >= minimumContribution, "minimum amount of contribution should be 100 wei");

        if(contributors[msg.sender] == 0 ){
            totalContributors++;
        }

        contributors[msg.sender]+=msg.value;
        totalFund += msg.value;
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function takeRefund() public payable  notManager {
        require(block.timestamp > deadLine, "Deadline is not over yet!");
        require(contributors[msg.sender] !=0 , "There is no funding from your side!");
        require(totalFund <target, "Target is met, now you can't get refund");

        address payable refundReceiver = payable(msg.sender);
        uint amount = contributors[refundReceiver];
        refundReceiver.transfer(amount);
    }

    function createRequests(string memory _description, address payable _recipient, uint _value) public onlyManager{
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;
    }

    function voteRequest(uint _requestNo) public{
        require(contributors[msg.sender]>0,"You nust be a contributor");
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.voters[msg.sender] == false, "you have already voted");
        thisRequest.voters[msg.sender] = true;
        thisRequest.noOfVoters++;        
    }
    
    function makePayment(uint _requestNo) public onlyManager{
        require(totalFund>=target);
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.completed==false,"the request has been completed");
        require(thisRequest.noOfVoters > totalContributors/2, "Majority does not support");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;
    }
}