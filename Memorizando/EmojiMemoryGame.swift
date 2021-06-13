//
//  EmojiMemoryGame.swift
//  Memorizando
//
//  Created by Geanderson Lemonte on 12/06/21.
//

import SwiftUI 
 


class EmojiMemoryGame: ObservableObject  { 
   @Published private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
   private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["😜", "😎", "😇", "👻"]
        return MemoryGame<String>(numberOfPairOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    
    
    // MARK - ACESS TO THE MODEL
    
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    
    // MARK -- INTENT(S)
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
    
    func resetGame() {
        game = EmojiMemoryGame.createMemoryGame()
    }
}
