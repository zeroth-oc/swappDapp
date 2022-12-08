pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
  string public name = "non hardhat token";
  string public symbol = "NHT";
  uint256 public totalSupply = 3333;
  address public owner;
  uint8 public decimals = 18;

  event Transfer(address indexed from, address indexed to, uint256 amount);
  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 amount
  );

  mapping(address => uint256) balances;
  mapping(address => mapping(address => uint256)) allowance;

  constructor() {
    balances[msg.sender] = totalSupply;
    owner = msg.sender;
  }

  function transfer(address to, uint256 amount) external {
    console.log("Sender balance is %s tokens", balances[msg.sender]);
    console.log("Trying to send %s tokens to %s", amount, to);
    require(balances[msg.sender] >= amount, "Not enough tokens");
    balances[msg.sender] -= amount;
    balances[to] += amount;
    emit Transfer(msg.sender, to, amount);
    return true;
  }

  function approve(address spender, uint256 amount) external {
    allowance[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
  }

  function transferFrom(
    address from,
    address to,
    uint256 amount
  ) external {
    require(amount <= balances[from], "Not enough tokens");
    require(
      amount <= allowance[from][msg.sender],
      "Not enough tokens approved"
    );
    balances[from] -= amount;
    balances[to] += amount;
    allowance[from][to] -= amount;
    emit Transfer(msg.sender, to, amount);
    return true;
  }

  function balanceOf(address account) external view returns (uint256) {
    return balances[account];
  }
}
