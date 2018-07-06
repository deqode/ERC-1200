pragma solidity ^0.4.11;


import "./Governable.sol";


/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is Governable {

    event Pause();
    event Unpause();
    event LOG(bool x);
    bool public paused = true;

    /**
    * @dev Modifier to make a function callable only when the contract is not paused.
    */
    modifier whenNotPaused(address _to) {
        var(adminStatus, ) = isAdmin(_to);
        LOG(!paused || adminStatus);
        require(!paused || adminStatus);
        _;
    }

    /**
    * @dev Modifier to make a function callable only when the contract is paused.
    */
    modifier whenPaused(address _to) {
        var(adminStatus, ) = isAdmin(_to);
        require(paused || adminStatus);
        _;
    }

    /**
    * @dev called by the owner to pause, triggers stopped state
    */
    function pause() public onlyAdmins whenNotPaused(msg.sender) {
        paused = true;
        Pause();
    }

    /**
    * @dev called by the owner to unpause, returns to normal state
    */
    function unpause() public onlyAdmins whenPaused(msg.sender) {
        paused = false;
        Unpause();
    }
}
