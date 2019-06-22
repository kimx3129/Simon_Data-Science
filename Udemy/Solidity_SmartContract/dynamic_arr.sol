pragma solidity ^0.5.1;

contract ArrayExercise{
    string public location = 'Korea';
    uint[] public prices;
    
    function add_price(uint _price) public{
        prices.push(_price);
    }
    
    function get_price_len() public view returns(uint){
        return prices.length;
    }
    
    function getValue(uint i) public view returns(uint){
        if (i < prices.length){
            return prices[i];
        }
    }
    
    function removeElts(uint idx) public returns(bool){
        if (idx >= prices.length){
            return false;
        }
        
        for (uint i = idx; i < prices.length; i++){
            if (i == prices.length - 1){
                break;
            }
            prices[i] = prices[i+1];
        }
        prices.length--;
        return true;
    }
}