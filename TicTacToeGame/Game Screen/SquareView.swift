//
//  SquareView.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 14.03.2023.
//

import SwiftUI

struct SquareView: View {
    @EnvironmentObject var game: GameServise
    @EnvironmentObject var connectionManager: MPConnectionManager
    let index: Int
    var body: some View {
        Button {
            if !game.isThinking {
                game.makeMove(at: index)
            }
            if game.gameType == .peer {
                let gameMove = MPGameMove(action: .move, playerName: connectionManager.myPeerId.displayName, index: index)
                connectionManager.send(gameMove: gameMove)
            }
        } label: {
            game.gameBoard[index].image
                .resizable()
                .frame(width: 100, height: 100)
        }
        .disabled(game.gameBoard[index].player != nil)
        .foregroundColor(.primary)

    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(index: 1)
            .environmentObject(GameServise())
            .environmentObject(MPConnectionManager(yourName: "NAME"))
    }
}
