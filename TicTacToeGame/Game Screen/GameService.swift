//
//  GameService.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 14.03.2023.
//

import Foundation

@MainActor
class GameServise: ObservableObject {
    
    @Published var player1 = Player(gamePiece: .x, name: "Player 1")
    @Published var player2 = Player(gamePiece: .x, name: "Player 2")
    @Published var possibleMoves = Move.all
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset
    
    var gameType = GameType.single
    
    var currentPlayer: Player {
        if player1.isCurrent {
            return player1
        } else {
            return player2
        }
    }
    var gameStarted: Bool {
        player1.isCurrent || player2.isCurrent
    }
    var boardDisable: Bool {
        gameOver || !gameStarted
    }
    
    func setupGame(gameType: GameType, player1Name: String, player2Name: String) {
        switch gameType {
        case .single:
            self.gameType = .single
            player2.name = player2Name
        case .bot:
            self.gameType = .bot
        case .peer:
            self.gameType = .peer
        case .undetermined:
            break
        }
        player1.name = player1Name
    }
    
    func resetGame() {
        player1.isCurrent = false
        player2.isCurrent = false
        
        player1.moves.removeAll()
        player2.moves.removeAll()
        
        gameOver = false
        possibleMoves = Move.all
        
        gameBoard = GameSquare.reset
    }
}
