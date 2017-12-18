pragma solidity ^0.4.19;

contract MyToken{

  mapping(address => uint) public balances;
  uint public tokenSupply;
  address public owner;
  mapping(address => mapping(address => uint)) approvals;

  // Constructor
  function MyToken() public{
      owner = msg.sender;
      tokenSupply = 1000;
  }

  //ERC20 Events
  event Transfer(address indexed _from, address indexed _to, uint _value);
  event Approval(address indexed _owner, address indexed _spender, uint _value);

  // ERC20 Functions
  function totalSupply() public view returns (uint){
      return tokenSupply;
  }

  function balanceOf(address _owner) public view returns (uint){
      return balances[_owner];
  }

  function transfer(address _to, uint _value) public returns (bool){
      // Basic check that address is valid and value is more than 0, for now.
      require(_to != address(0));
      require(_value > 0);
      balances[_to] += _value;
      Transfer(owner, _to, _value);
      return true;
  }

  function transferFrom(address _from, address _to, uint _value) public returns (bool){
      require(_to != address(0));
      require(_from != address(0));
      require(_value > 0);
      require(_value >= balances[_from]);
      balances[_from] -= _value;
      balances[_to] += _value;
      Transfer(_from, _to, _value);
      return true;
  }

  function approve(address _spender, uint _value) public returns (bool success){
      require(_spender != address(0));
      require(_value > 0);
      require(_value <= balances[msg.sender]);
      approvals[msg.sender][_spender] = _value;
      return true;
      Approval(msg.sender, _spender, _value);

  }

  function allowance(address _owner, address _spender) public view returns (uint remaining){
      return approvals[_owner][_spender];
  }

}
