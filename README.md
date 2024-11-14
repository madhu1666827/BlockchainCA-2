# BlockchainCA-2
# UserManagement Smart Contract

## Overview
`UserManagement` is a Solidity-based smart contract for managing admin and regular user roles. It leverages OpenZeppelin's ECDSA library for signature verification to ensure secure user additions.

## Issues and Fixes

### 1. **Signature Reuse Prevention**
- **Issue**: Allowed signature reuse, enabling unauthorized repeated calls.
- **Solution**: Added `usedSignatures` mapping to track and prevent reuse.

### 2. **Event Emissions**
- **Issue**: Lack of event emissions for tracking state changes.
- **Solution**: Added `AdminAdded` and `RegularUserAdded` events.

### 3. **Gas Optimization**
- **Issue**: Potentially high gas costs due to redundant updates.
- **Solution**: Implemented checks to prevent adding duplicate entries.

### 4. **Replay Attack Protection**
- **Issue**: Vulnerable to replay attacks across different contract instances.
- **Solution**: Included contract address in the hash to bind the signature.

## Usage
1. Deploy the contract in Remix or another compatible environment.
2. Use `addUsers()` with valid input and signature.
3. Monitor events for state changes.

## Requirements
- **Solidity Version**: ^0.8.0
- **Dependencies**: OpenZeppelin ECDSA v4.3.2
