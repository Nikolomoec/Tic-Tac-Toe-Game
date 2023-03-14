//
//  GamevIEW.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 14.03.2023.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var game: GameServise
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy { $0 == false } {
                Text("Select a player to start")
            }
            HStack {
                Button(game.player1.name) {
                    game.player1.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))
                
                Button(game.player2.name) {
                    game.player2.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player2.isCurrent))
            }
            .disabled(game.gameStarted)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("End Game") {
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("Tic Tac Toe Game")
        .isNavStack()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameServise())
    }
}

struct PlayerButtonStyle: ButtonStyle {
    let isCurrent: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isCurrent ? Color.green : Color.gray)
            )
            .foregroundColor(.white)
    }
}
