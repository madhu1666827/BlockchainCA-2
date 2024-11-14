// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v4.3.2/contracts/utils/cryptography/ECDSA.sol";


contract UserManagement {
    using ECDSA for bytes32;
    
    mapping(address => bool) public isAdmin;
    mapping(address => bool) public isRegularUser;
    mapping(bytes32 => bool) private usedSignatures;

    event AdminAdded(address indexed admin);
    event RegularUserAdded(address indexed user);

    function addUsers(address[] calldata admins, address[] calldata regularUsers, bytes calldata signature) external {
        require(isAdmin[msg.sender] || _isAuthorized(admins, regularUsers, signature), "Only admins can add users.");

        for (uint256 i = 0; i < admins.length; i++) {
            address admin = admins[i];
            if (!isAdmin[admin]) {
                isAdmin[admin] = true;
                emit AdminAdded(admin);
            }
        }

        for (uint256 i = 0; i < regularUsers.length; i++) {
            address user = regularUsers[i];
            if (!isRegularUser[user]) {
                isRegularUser[user] = true;
                emit RegularUserAdded(user);
            }
        }
    }

    function _isAuthorized(address[] calldata admins, address[] calldata regularUsers, bytes calldata signature) private returns (bool) {
        bytes32 hash = keccak256(abi.encodePacked(admins, regularUsers));
        bytes32 messageHash = ECDSA.toEthSignedMessageHash(hash);


        require(!usedSignatures[messageHash], "Signature already used.");
        usedSignatures[messageHash] = true;

        address signer = messageHash.recover(signature);
        return isAdmin[signer];
    }
}
