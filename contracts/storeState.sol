//import solidity
pragma solidity ^0.5.11;

//First contract
contract storeState {
  address public owner;
  uint public contractExpiry;

  //mapping(address => string) public States;
  //mapping(address => uint) public contractExpiryTimes;

  //Enum type
  enum ConStates { Unknown, Alive, Missing}
  ConStates state;

  //event
  event contractCreated( address author, uint expiry, ConStates state );

  //constructor to initialise state variables
  constructor() public{
    owner = msg.sender;
    setDefault();
    emit contractCreated(owner,contractExpiry,state);
  }
//Defining owner restrictions
  modifier restricted() {
    if (msg.sender == owner) _;
  }

//Function to set default state and contract expiry time.
function setDefault() public {
        state = ConStates.Unknown;
        contractExpiry = block.timestamp + 60 seconds;
    }

//Function to update 'missing' state if the time is beyond expiry time
function checkTimeout() public{
  if(now >= contractExpiry)
  {
    state = ConStates.Missing;
  }
}

function setState(string memory userMsg) public restricted{
  //compares the user message(basically for string comparison)
  if(keccak256(abi.encodePacked((userMsg))) == keccak256(abi.encodePacked(("I'm alive"))) )
  {
    state = ConStates.Alive;
    contractExpiry = now + 60 seconds;
  }
}
function getState() public view returns (ConStates)  {
    return state;
  }
}
