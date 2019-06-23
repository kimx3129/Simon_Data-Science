pragma solidity ^0.5.1;

contract Auction{

    struct Car{
        string description;
        uint price;
        uint built_year;
    }
    
    Car public private_car;
    mapping(address => Car) public cars;
    
    enum State {Running, Stop, Inactive}
    
    State public status = State.Running;
    
    // initialize variable using constructor
    constructor(string memory _description, uint _price, uint _built_year) public{
        private_car.description = _description;
        private_car.price = _price;
        private_car.built_year = _built_year;
        
        // add this private_car to mapping structure
        // msg.sender : address of the account that owns 
        // private car
        cars[msg.sender] = private_car;
    }
    
    function modify_car(string memory _description, uint _price, uint _built_year) public returns(bool){
        if(status == State.Running){
            //use memory keyword to store in memory
            Car memory newCar = Car({
                description: _description,
                price: _price,
                built_year: _built_year
            });
            
            private_car = newCar; // it only changes a struct var
            return true;
        }else{
            return false;
        }
    }
}