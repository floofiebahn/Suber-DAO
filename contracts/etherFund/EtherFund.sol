import "./../etherTreasury/EtherTreasury.sol";
import "./../votingEngine/VotingEngineHelpers.sol";
pragma solidity ^0.4.24;

//TODO: make the constructor into an array
// TODO: make a forwarder as well, to be able to specify another etherTreasury, but prevent ether from being lost when the old address is used.
contract EtherFund {


    event sponsorShipReceived(bytes32 hash, address indexed callee, uint256 amount);

    EtherTreasury etherTreasury;

    mapping(address => bool) allowedAddresses;

    constructor(address initialEtherTreasury) {
        allowedAddresses[initialEtherTreasury] = true;
    }

    /**
     * @dev sponsors can use this function to grant funds to the DAO
     * @notice this is not the only way how funds can be given to the DAO. We have the possibilities selfdescruct or mining to the contract address
     * @notice we emit a hash with the event, which can be the fingerprint from a file (logo/advertisement/SWARM URL).
     */
    function payTribute(bytes32 hash) public payable {
        require(msg.value > 0);
        emit sponsorShipReceived(hash, msg.sender, msg.value);
    }

    function withdraw(address to, uint256 amount) {
        require(allowedAddresses[msg.sender]);
        to.transfer(amount);
    }
}
