//
//  TicTacToeGameApp.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 14.03.2023.
//

import SwiftUI

@main
struct AppEntry: App {
    @StateObject var game = GameServise()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game)
        }
    }
}
