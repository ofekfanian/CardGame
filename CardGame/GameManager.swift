import Foundation

// MARK: GameManager
class GameManager {

    private var redDeck: [Card] = []    // hearts + diamonds
    private var blackDeck: [Card] = []  // spades + clubs

    // ace = 14 (highest), two = 2
    private let ranks = ["two", "three", "four", "five", "six", "seven",
                         "eight", "nine", "ten", "jack", "queen", "king", "ace"]

    // cards with no asset present in the catalog
    private let missing: Set<String> = [
        "two of diamonds", "ace of diamonds",
        "nine of hearts", "ten of hearts", "jack of hearts"
    ]

    init() {
        redDeck   = buildRed()
        blackDeck = buildBlack()
    }

    private func buildRed() -> [Card] {
        var deck: [Card] = []
        for (i, rank) in ranks.enumerated() {
            for suit in ["hearts", "diamonds"] {
                let name = "\(rank) of \(suit)"
                guard !missing.contains(name) else { continue }
                deck.append(Card(value: i + 2, imageName: name))
            }
        }
        return deck.shuffled()
    }

    private func buildBlack() -> [Card] {
        var deck: [Card] = []
        for (i, rank) in ranks.enumerated() {
            for suit in ["spades", "clubs"] {
                deck.append(Card(value: i + 2, imageName: "\(rank) of \(suit)"))
            }
        }
        return deck.shuffled()
    }

    func drawRedCard() -> Card {
        if redDeck.isEmpty { redDeck = buildRed() }
        return redDeck.removeLast()
    }

    func drawBlackCard() -> Card {
        if blackDeck.isEmpty { blackDeck = buildBlack() }
        return blackDeck.removeLast()
    }
}
