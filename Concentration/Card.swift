//
//  Card.swift
//  Concentration
//
//  Created by JunGuan on 2018/7/9.
//  Copyright © 2018 JunGuan. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int {
        return identifier
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    private static var identifierFactory = 0

    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
