import images                           from "./ImageLoader"
import config                           from './config'
import { coordsToIndex, indexToCoords } from "./utils";

class Rook {
  constructor(coords, pieceCode) {
    this.x = coords.x
    this.y = coords.y
    this.row = coords.row
    this.col = coords.col
    this.img = pieceCode > 0 ? images.b_rook : images.w_rook
    this.code = pieceCode
    this.magnitude = this.code / Math.abs(this.code)
  }

  getPossibleMoves(player, board) {
    let currentIndex = coordsToIndex(this.row, this.col)
    let possibleMoves = []

    let blocked = false
    let tilesAdvanced = 0
    let lastIndexChecked = currentIndex
    while(!blocked) { // move forward
      tilesAdvanced += config.cols
      let proposedIndex = currentIndex + (tilesAdvanced * this.magnitude)
      if (!this.inBounds(lastIndexChecked, proposedIndex)) {
        break // can't advance off the board
      }
      lastIndexChecked = proposedIndex
      let pieceOnTile = board[proposedIndex]
      if(pieceOnTile) {
        if(player.ownsPiece(pieceOnTile.code)) {
          blocked = true
        }
        else {
          possibleMoves.push(proposedIndex)
          blocked = true
        }
      } else {
        possibleMoves.push(proposedIndex)
      }
    }

    blocked = false
    tilesAdvanced = 0
    lastIndexChecked = currentIndex
    while(!blocked) { // move back
      tilesAdvanced += config.cols
      let proposedIndex = currentIndex - (tilesAdvanced * this.magnitude)
      if (!this.inBounds(lastIndexChecked, proposedIndex)) {
        break // can't advance off the board
      }
      lastIndexChecked = proposedIndex
      let pieceOnTile = board[proposedIndex]
      if(pieceOnTile) {
        if(player.ownsPiece(pieceOnTile.code)) {
          blocked = true
        }
        else {
          possibleMoves.push(proposedIndex)
          blocked = true
        }
      } else {
        possibleMoves.push(proposedIndex)
      }
    }

    blocked = false
    tilesAdvanced = 0
    lastIndexChecked = currentIndex
    while(!blocked) { // move right
      tilesAdvanced += 1
      let proposedIndex = currentIndex + tilesAdvanced
      if (!this.inBounds(lastIndexChecked, proposedIndex)) {
        break // can't advance off the board
      }
      lastIndexChecked = proposedIndex
      let pieceOnTile = board[proposedIndex]
      if(pieceOnTile) {
        if(player.ownsPiece(pieceOnTile.code)) {
          blocked = true
        }
        else {
          possibleMoves.push(proposedIndex)
          blocked = true
        }
      } else {
        possibleMoves.push(proposedIndex)
      }
    }

    blocked = false
    tilesAdvanced = 0
    lastIndexChecked = currentIndex
    while(!blocked) { // move left
      tilesAdvanced += 1
      let proposedIndex = currentIndex - tilesAdvanced
      if (!this.inBounds(lastIndexChecked, proposedIndex)) {
        break // can't advance off the board
      }
      lastIndexChecked = proposedIndex
      let pieceOnTile = board[proposedIndex]
      if(pieceOnTile) {
        if(player.ownsPiece(pieceOnTile.code)) {
          blocked = true
        }
        else {
          possibleMoves.push(proposedIndex)
          blocked = true
        }
      } else {
        possibleMoves.push(proposedIndex)
      }
    }

    return possibleMoves
  }

  showPossibleMoves(player, board, ctx) {
    this.getPossibleMoves(player, board).forEach(proposedIndex => {
      let proposedCoords = indexToCoords(proposedIndex)
      ctx.fillRect(proposedCoords.x, proposedCoords.y, config.tileWidth, config.tileHeight)
    })
  }

  inBounds(prevIndex, nextIndex) {
    if (nextIndex < 0) {
      return false
    }
    if (nextIndex > config.cols * config.rows - 1) {
      return false
    }
    if (prevIndex - nextIndex === 1 && prevIndex % 8 === 0) {
      return false
    }
    if (nextIndex - prevIndex === 1 && nextIndex % 8 === 0) {
      return false
    }
    return true
  }

  move(coords) {
    this.x = coords.x
    this.y = coords.y
    this.row = coords.row
    this.col = coords.col
  }
}

export default Rook