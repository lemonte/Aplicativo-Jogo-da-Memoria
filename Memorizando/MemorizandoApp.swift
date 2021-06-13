//
//  MemorizandoApp.swift
//  Memorizando
//
//  Created by Geanderson Lemonte on 10/06/21.
//

import SwiftUI 

@main
struct MemorizandoApp: App { 
    var body: some Scene { 
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
