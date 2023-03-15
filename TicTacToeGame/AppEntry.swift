//
//  TicTacToeGameApp.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 14.03.2023.
//

import SwiftUI

@main
struct AppEntry: App {
    @AppStorage("yourName") var yourName = ""
    @StateObject var game = GameServise()
    var body: some Scene {
        WindowGroup {
            if yourName.isEmpty {
                YourNameView()
            } else {
                StartView(yourName: yourName)
                    .environmentObject(game)
            }
        }
    }
}
