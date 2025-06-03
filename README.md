# FashionAuth - Luxury Item Authentication System

A Clarity smart contract for authenticating luxury fashion items on the Stacks blockchain.

## Overview

FashionAuth provides a decentralized solution for luxury brands to authenticate their products and combat counterfeiting. The system allows verified brands to register items with unique identifiers and metadata.

## Features

- **Brand Registration**: Luxury brands can register and get verified status
- **Item Authentication**: Mint authentication certificates for products
- **Public Verification**: Anyone can verify item authenticity
- **Immutable Records**: Blockchain-based proof of authenticity

## Contract Functions

### Public Functions

- `register-brand(name)` - Register a new brand
- `authenticate-item(brand, model, serial-number, manufacture-date)` - Authenticate a luxury item

### Read-Only Functions

- `verify-item(item-id)` - Check if an item is authentic
- `get-brand-info(brand)` - Get brand registration details
- `get-next-item-id()` - Get the next available item ID

## Usage

1. Brands register using `register-brand`
2. Authenticated items are added via `authenticate-item`
3. Consumers verify authenticity using `verify-item`

## Development

\`\`\`bash
clarinet check
clarinet test
\`\`\`