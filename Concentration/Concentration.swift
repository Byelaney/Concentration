//
//  Concentration.swift
//  Concentration
//
//  Created by JunGuan on 2018/7/9.
//  Copyright © 2018 JunGuan. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()

    var indexOfOneAndOnlyFaceUpCard: Int?

    private(set) var flipCount = 0

    private(set) var score = 0

    private var previouslySeen:Set<Card> = []

    // game can have many themes
    var themes: [Theme] = []

    // only one in use
    var themeInUse: Theme = Theme(with: ["😀", "😁", "😂", "🤣", "😃", "😄"])

    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()

        // randomly pick one default themes
        let defaultThemes = [["😀", "😁", "😂", "🤣", "😃", "😄"],
                             ["🧥", "👚", "👕", "👖", "👔", "👗"],
                             ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊"],
                             ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌"],
                             ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐"],
                             ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎"]]
        for theme in defaultThemes {
            themes.append(Theme(with: theme))
        }
        themes.shuffle()
        themeInUse = themes[0]
    }

    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if previouslySeen.contains(cards[index]) {
                        score -= 1
                    }
                }
                previouslySeen.insert(cards[index])
                previouslySeen.insert(cards[matchIndex])
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                if previouslySeen.contains(cards[index]) {
                    score -= 1
                }
                previouslySeen.insert(cards[index])
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
