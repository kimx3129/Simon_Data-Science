pragma solidity ^0.5.1;

contract Auction{
    address public owner;
    uint public startBlock;
    uint public endBlock; // startBlock and endBlock to calculate auction duration
    string public ipfshash; // store product information as a hash
    
    enum State {Started, Running, Ended, Canceled}
    State public auctionState;
    uint public bidIncrement;
    
    uint public highestBindingBid; // the price for the highest bid price
    address payable public highestBidder; // the address for the highest bid
    
    mapping(address => uint) public bids; // save all bids
    
    // constructor(uint _startBlock, uint _endBlock, string memory _ipfshash, uint _bidIncrement) public{
    //     owner = msg.sender;
    //     auctionState = State.Running;
    //     startBlock = _startBlock;
    //     endBlock = _endBlock;
    //     ipfshash = _ipfshash;
    //     bidIncrement = _bidIncrement;
    // }
    
    constructor() public{
        owner = msg.sender;
        auctionState = State.Running;
        startBlock = block.number;
        endBlock = startBlock + 3;
        ipfshash = "";
        bidIncrement = 1000000000000000000;
    }   
    
    modifier notOwner(){ // modifier to restrict access everyone except contract owner
        require(msg.sender != owner);
        _;
    }
    
    modifier onlyOwner(){ // modifier to restrict access to the contract owner only
        require(msg.sender == owner);
        _;
    }
    
    modifier afterStart(){ // check if bidding time is only valid before auction end time
        require(block.number >= startBlock);
        _;
    }
    
    modifier beforeEnd(){ // check if bidding time is before auction is over
        require(block.number <= endBlock);
        _;
    }
    
    // function to return a minimum value
    function min(uint val1, uint val2) pure internal returns(uint){
        if (val1 >= val2){
            return val2;
        }else{
            return val1;
        }
    }
    
    // a function to cancel the auction (only by the contract owner)
    function cancelAuction() onlyOwner public{
        auctionState = State.Canceled;
    }
    
    function placeBid() payable notOwner afterStart beforeEnd public returns(bool){
        // check if auction is in a running state
        require(auctionState == State.Running);
        
        // to hinder if someone tries to send 0 ETH. Minimum value > 0.001 ETH
        // require(msg.value > 0.001 ether);
        
        uint currentBid = bids[msg.sender] + msg.value; // sum the current bid price + new bid price
        
        require(currentBid > highestBindingBid); // if currentBid is greater than highest binding bid, update the value
        
        bids[msg.sender] = currentBid;
        
        // check a couple of conditions
        // [1] if currentBid is less than the value sent by highest bidder
        if(currentBid <= bids[highestBidder]){
            // highest bidder doesn't change, but update the HBB
            highestBindingBid = min(currentBid + bidIncrement, bids[highestBidder]);
        }else{
            highestBindingBid = min(currentBid, bids[highestBidder] + bidIncrement);
            highestBidder = msg.sender;
        }
        
        return true;
    }
    
    function finalizeAuction() public{
        // check if auction state is ended or auction time is over
        require(auctionState == State.Canceled || block.number > endBlock); 
        
        // owner doesn't have to wait until auction is completed or cancelled
        // this require is checking if the participants sent a ETH to the auction. 
        require(msg.sender == owner || bids[msg.sender] > 0);
        
        address payable recipient;
        uint value;
        
        // consider two possible cases
        // [1] if auction is canceleed
        if(auctionState == State.Canceled){ // everyone gets their own fund
            recipient = msg.sender;
            value = bids[recipient];
        }else{ // when the owner finalized the auction
            if(msg.sender == highestBidder){
                recipient = highestBidder;
                value = bids[recipient] - highestBindingBid;
            }else{
                recipient = msg.sender;
                value = bids[recipient];
            }
        }
        
        recipient.transfer(value); // it transfers the value to the recipient
    }
}