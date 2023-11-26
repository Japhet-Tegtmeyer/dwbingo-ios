//
//  BingoCard.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/13/23.
//

import Foundation
import SwiftUI

// MARK: - Card Struct

struct Card {
    var bcard: String // Image name of the Bingo card
    var cardId: Int // Unique identifier for the Bingo card
    var color: Color // Color associated with the Bingo card
}

// MARK: - BingoCards Struct

struct BingoCards {
    
    // MARK: - Bingo Card Array
    
    var bingoCards = [
        Card(bcard: "DisneyBingo", cardId: 001, color: .colorD1),
        Card(bcard: "DisneyBingo1", cardId: 002, color: .colorD2),
        Card(bcard: "DisneyBingo2", cardId: 003, color: .colorD3),
        Card(bcard: "DisneyBingo3", cardId: 004, color: .colorD11),
        Card(bcard: "DisneyBingo4", cardId: 005, color: .colorD4),
        Card(bcard: "DisneyBingo5", cardId: 006, color: .colorD5),
        Card(bcard: "DisneyBingo6", cardId: 007, color: .colorD6),
        Card(bcard: "DisneyBingo7", cardId: 008, color: .colorD7),
        Card(bcard: "DisneyBingo8", cardId: 009, color: .colorD8),
        Card(bcard: "DisneyBingo9", cardId: 010, color: .colorD9),
        Card(bcard: "DisneyBingo10", cardId: 011, color: .colorD10),
        Card(bcard: "DisneyBingo11", cardId: 012, color: .colorD12),
        Card(bcard: "DisneyBingo12", cardId: 013, color: .colorD13),
        Card(bcard: "DisneyBingo13", cardId: 014, color: .colorD14),
    ]
}
