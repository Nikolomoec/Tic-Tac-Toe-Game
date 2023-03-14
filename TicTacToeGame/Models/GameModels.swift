//
//  GameModels.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 14.03.2023.
//

import Foundation

enum GameType {
    case single, bot, peer, undetermined
    
    var description: String {
        switch self {
        case .single:
            return "Share your Iphone/Ipad with your friends!"
        case .bot:
            return "Play against this Iphone/Ipad!"
        case .peer:
            return "Play with your friends on the same network!"
        case .undetermined:
            return ""
        }
    }
}
