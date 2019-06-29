pragma solidity ^0.5.1;

contract Property{
    uint public price = 90000;
    string public location = 'Korea';
    address public owner;
    address public caller;
    uint public last_sent_value;
    
    // Explore some global variables
    uint public this_moment = now;
    uint public _now = block.timestamp;
    uint public block_number = block.number;
    uint public difficulty = block.difficulty;
    uint public gas_limit = block.gaslimit;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function get_balance() view public returns(uint){
        return address(this).balance;
    }

    function() payable external{ //fallback function since it doesn't have function name
        location = 'Chicago';
    }
    
    function transfer_balance(address payable recepient_addr, uint amount) public returns(bool){
        if(msg.sender == owner){
             // the amount must be less than or equal to the contract balance
            if(amount <= get_balance()){
                recepient_addr.transfer(amount);
                return true;
            }else{
                return false;
            }           
        }else{
            return false;
        }
    }
    
    function sendEther() payable public{
        price = 10;
    }
    
    function setPrice(uint _price) public{
        caller = msg.sender;
        price = _price;
    }
    
    function setLocation(string memory _location) public{
        caller = msg.sender;
        location = _location;
    }
    
    
    // example function
    function f() view public returns(uint){
        //return how much gas will be spent to call this function
        uint start = gasleft();
        
        uint j = 5;
        for(uint i = 0; i < 10; i++){
            j++;
        }
        
        return start - gasleft();
    }
}