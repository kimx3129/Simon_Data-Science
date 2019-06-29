pragma solidity ^0.5.1;

contract A{
    // define state variables (by default, private and internal)
    int x = 35;
    
    // if a variable is public, a getter function will be created by default
    int public y = 100;
    
    
    // in order to access state variables, getter functions are mandatory
    function getX() view public returns(int){
        return x;
    }
    
    function getY() view public returns(int){
        return y;
    }
    
    // it will not be visible to the remix ui window since it is private
    function getY_p() view private returns(int){
        return y;
    }    
    
    // in this function a private function is used
    function f3() view public returns(int){
        return getY_p();
    }
    
    // same for private, it will not be visible to the remix ui window since it is internal
    function func_i() view internal returns(int){
        return x;
    } 
    
    // only accessed from outside, not within this contract
    function func_e() view external returns(int){
        return y;
    }
    
}

contract B{
    A public contract_a = new A(); // create a new contract object. contract B deploys contract A
    int public xx = contract_a.getY(); // getY() function can be called from other contract since it is public
    //int public yy = contract_a.getY_p(); // <- it will occur an error since getY_p is a private function
    //int public xxx = contract_a.func_i(); // <- also error. Only derived contract can call an internal function
}

// A derived contract
contract C is A{ // <- Contract C derives from A
    int public xx = func_i(); // can be called :) Similar concept like 'protected'
}