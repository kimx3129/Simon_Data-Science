pragma solidity ^0.5.1;

contract Property{
    uint public price = 3000;
    string public location = 'Korea';
    address public owner;
    
    constructor() public{
        owner = msg.sender; //initialize the owner
    }
    
    modifier onlyOwner(){ // this is the structure of function modifier
        require(msg.sender == owner);
        _;
    }    
    
    function get_balance() view public onlyOwner returns(uint){
        return address(this).balance;
    }
    
    // create a transaction and costs a gas
    function setPrice(uint _price) onlyOwner public{
        require(_price > price);
        price = _price;
    }
    
    function setLocation(string memory _location) onlyOwner public{
        location = _location;
    }
}