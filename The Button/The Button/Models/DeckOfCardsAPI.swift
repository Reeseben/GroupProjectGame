//
//  DeckOfCardsAPI.swift
//  The Button
//
//  Created by Andrew Saeyang on 8/18/21.
//

import Foundation

// MARK: - TopLevelObject
struct TopLevelObject: Codable {
    let success: Bool
    let cards: [Card]
    let deckID: String
    let remaining: Int

    enum CodingKeys: String, CodingKey {
        case success, cards
        case deckID = "deck_id"
        case remaining
    }
}

// MARK: - Card
struct Card: Codable {
    let image: URL
    let value, suit, code: String
}


// MARK: - Shuffled
struct Shuffled: Codable {
    let deckID: String
    let remaining: Int
    let shuffled: Bool

    enum CodingKeys: String, CodingKey {
        case deckID = "deck_id"
        case remaining, shuffled
    }
}


