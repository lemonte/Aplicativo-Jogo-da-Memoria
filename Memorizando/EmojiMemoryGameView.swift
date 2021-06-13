//
//  EmojiMemoryGameView.swift
//  Memorizando
//
//  Created by Geanderson Lemonte on 10/06/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    var body: some View {
        VStack {
            Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture  {
                    withAnimation(.linear) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(.orange)
            Button(action: {
                withAnimation(.easeOut) {viewModel.resetGame()}
            }, label: { Text("Novo Jogo")})
        }
    } 
}



struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View { 
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedRemaining: Double = 0
    
    private func startTimeAnimation() {
        animatedRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaning)) {
            animatedRemaining = 0
        }
    }
    
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {  
        if card.isFaceUp || !card.isMatched  {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedRemaining*360-90), clockwise: true)
                            .onAppear {
                                startTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                .transition(.scale)
                Text(card.content)
                    .font(Font.system(size: min(size.width, size.height) * fontScaleFactor))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            .rotation3DEffect(
                Angle.degrees(card.isFaceUp ? 0 : 180),
                axis: (0,1,0)
            ) 
        }
    }
}
private  let fontScaleFactor: CGFloat = 0.7

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
