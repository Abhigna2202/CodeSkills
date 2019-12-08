const storeState = artifacts.require('storeState')

function sleep(milliseconds) {
    const date = Date.now();
    let currentDate = null;
    do {
      currentDate = Date.now();
    } while (currentDate - date < milliseconds);
  }

contract('storeState', function(accounts) {
  it('the first state is Unknown', async function() {
      
    const contract = await storeState.deployed()

    // Once we have the "contract" we can make calls or transations and then assert.
    // The following is making a call to get the creator.
    const conState = await contract.getState()

    assert.equal(conState, 0, 'state is Unknown')
  })
  it('set status to "Missing" after 10 seconds when checkTimeout called', async function() {
    const contract = await storeState.deployed()
    sleep(60000);
    await contract.checkTimeout()
    const conState = await contract.getState()
    
    assert.equal(conState, 2, 'state is Missing')
    
  })
  it('set status to "Alive" when setState called with "I\'m alive" message', async function() {
    const contract = await storeState.deployed()

    // Execute a transaction and change the state of the contract.
    await contract.setState("I'm alive")

    // Get the new state.
    const conState = await contract.getState()

    assert.equal(conState, 1, 'state is Alive')
  })
})