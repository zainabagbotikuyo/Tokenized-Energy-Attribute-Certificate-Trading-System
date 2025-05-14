# Tokenized Energy Attribute Certificate (EAC) Trading Platform

A blockchain-based solution for verifying, tracking, trading, and retiring Energy Attribute Certificates.

## Overview

This platform leverages blockchain technology to create a transparent, secure, and efficient marketplace for Energy Attribute Certificates. EACs represent the environmental attributes of renewable energy generation and can be traded separately from the physical electricity.

The system consists of five core smart contracts that work together to ensure integrity throughout the EAC lifecycle:

1. **Generator Verification Contract**: Validates and registers renewable energy producers
2. **Production Tracking Contract**: Records and verifies energy generation amounts
3. **Certificate Issuance Contract**: Creates tradable EAC tokens
4. **Trading Contract**: Manages the marketplace for buying and selling EACs
5. **Retirement Contract**: Permanently removes EACs from circulation once used

## Key Features

- **Transparent Verification**: Public validation of renewable energy generators
- **Immutable Record-Keeping**: Tamper-proof tracking of energy production
- **Tokenized Certificates**: EACs represented as digital assets on blockchain
- **Efficient Trading**: Peer-to-peer marketplace with reduced intermediaries
- **Verifiable Retirement**: Transparent record of certificate retirement for claims
- **Reduced Double-Counting**: Prevention of certificates being claimed multiple times

## Architecture

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│    Generator    │     │    Production   │     │   Certificate   │
│   Verification  │────▶│    Tracking     │────▶│    Issuance     │
│    Contract     │     │    Contract     │     │    Contract     │
└─────────────────┘     └─────────────────┘     └────────┬────────┘
                                                        │
                                                        ▼
                        ┌─────────────────┐     ┌─────────────────┐
                        │    Retirement   │◀────│     Trading     │
                        │    Contract     │     │    Contract     │
                        └─────────────────┘     └─────────────────┘
```

## Contract Details

### Generator Verification Contract

Responsible for validating and registering renewable energy producers on the platform.

- Verifies generator credentials and facility information
- Stores generator metadata (location, technology type, capacity)
- Issues unique digital identities to verified generators
- Manages approvals and revocations

### Production Tracking Contract

Tracks the actual production of renewable energy by verified generators.

- Records metered generation data
- Validates production claims
- Links generation to specific time periods
- Maintains auditable history of production

### Certificate Issuance Contract

Creates tradable EAC tokens based on verified energy production.

- Mints EAC tokens corresponding to MWh generated
- Embeds metadata (generation source, time, location)
- Manages certificate attributes and compliance standards
- Ensures uniqueness and prevents duplication

### Trading Contract

Facilitates the buying and selling of EAC tokens.

- Manages listings, bids, and asks
- Executes trades and transfers ownership
- Provides pricing transparency
- Handles escrow and settlement

### Retirement Contract

Manages the permanent removal of EACs from circulation once they are claimed.

- Records retirement reason and beneficiary
- Prevents further trading of retired certificates
- Maintains public registry of retired certificates
- Generates retirement attestations

## Getting Started

### Prerequisites

- Node.js (v14+)
- Hardhat or Truffle development environment
- MetaMask or similar Web3 wallet
- Access to Ethereum testnet (Rinkeby, Goerli) or mainnet

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/tokenized-eac-trading.git
   cd tokenized-eac-trading
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Compile smart contracts:
   ```
   npx hardhat compile
   ```

4. Deploy to testnet:
   ```
   npx hardhat run scripts/deploy.js --network rinkeby
   ```

### Testing

Run comprehensive tests:
```
npx hardhat test
```

## Usage

### For Energy Generators

1. Apply for verification through the Generator Verification interface
2. Submit required documentation and facility information
3. Once approved, connect your metering system to report production
4. Receive EAC tokens automatically based on verified generation

### For EAC Buyers/Traders

1. Connect your wallet to the platform
2. Browse available EAC listings by various attributes (location, technology, vintage)
3. Place bids or purchase certificates directly
4. Manage your EAC portfolio through the dashboard

### For End Users/Corporates

1. Purchase EACs to meet renewable energy goals
2. Retire certificates through the Retirement Contract
3. Receive verifiable proof of retirement for reporting
4. Track your environmental impact through the dashboard

## Future Roadmap

- **Enhanced Analytics**: Advanced reporting and visualization tools
- **Mobile App**: On-the-go access to the platform
- **Cross-Chain Integration**: Support for multiple blockchain networks
- **Automated Compliance**: Built-in reporting for regulatory frameworks
- **Carbon Offsetting**: Integration with carbon credit marketplaces

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or support, please contact us at support@tokenized-eac.example.com or join our Discord community.
