pragma solidity ^0.8.0;

import "./Token.sol";

contract Token {
  string public name = "swap exchange";
  Token public token;
  uint8 public rate = 100;

  event TokensPurchased(
    address account,
    address token,
    uint256 amount,
    uint256 rate
  );
  event TokenSold(address account, address token, uint256 amount, uint256 rate);

  constructor(Token _token) {
    token = _token;
  }

  function buyTokens(address to, uint256 amount) public payable {
    uint256 tokenAmount = msg.value * rate;
    require(token.balances(address(this)) >= tokenAmount);
    token.transfer(msg.sender, tokenAmount);

    emit TokensPurchased(msg.sender, address(token), tokenAmount, rate);
    return true;
  }

  function sellTokens(uint256 amount) public {
    require(token.balances(msg.sender) >= amount);
    uint256 ethAmount = amount / rate;
    require(address(this).balance >= ethAmount);
    token.transferFrom(msg.sender, address(this), amount);
    msg.sender.transfer(ethAmount);
    emit TokenSold(msg.sender, address(token), amount, rate);
    return true;
  }
}
