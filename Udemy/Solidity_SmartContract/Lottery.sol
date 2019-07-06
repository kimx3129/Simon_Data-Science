pragma solidity ^0.5.1;

contract Lottery{
    address payable[] public players; // players address container
    address public manager; // a manager address
    
    constructor() public{
        manager = msg.sender; // this variable only runs once and can't be modified
    }
    
    function() payable external{
        require(msg.value >= 0.01 ether);
        players.push(msg.sender); // add sender address to the array
    }
    
    function get_balance() view public returns(uint){
        require(msg.sender == manager); // only manager can view contract balance
        return address(this).balance; // return a contract balance
    }
    
    function random() private view returns(uint256){
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }
    
    function selectWinner() public{
        require(msg.sender == manager); // only manager send ETH and select the winner
        
        uint r = random();
        address payable winner = players[r % players.length];
        
        // transfer contract balance to the winner
        winner.transfer(address(this).balance);
        
        // reset the player array
        players = new address payable[](0); // <- dynamic array with size 0
    }
}