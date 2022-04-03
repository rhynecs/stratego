# stratego

## Repo

[available on github](https://github.com/rhynecs/stratego)

## Code style guide

Code will attempt to follow the style conventions outlines in the [Ruby Style Guide](https://rubystyle.guide/)

## Features

### Graphic representation of stratego board
- Displayed as a 2D grid with each piece represented as a character
- Axis on all sides of the grid to make identifying the correct cell easy
- Game board updates on start of new turn
- Different colors make identifying pieces easier
- Implemented with gem 'Rainbow'

### Piece selection and movement via text input of grid coordinate values
- Users can type coordinate commands like 'a3 a4'
  - a3 selects a piece
  - a4 selects where to move / attack
- Commands are validated to ensure correct syntax and legality

### All traditional stratego pieces are emulated
- Capturing flag wins the game
- Bombs destroy all units except the miner (8)
- The spy can kill the marshall if it attacks first (S)
- The scout can move any number of tiles in a direction and 