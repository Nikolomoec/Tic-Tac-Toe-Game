//
//  ContentView.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 14.03.2023.
//

import SwiftUI

struct StartView: View {
    
    @State private var gameType: GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack {
            Picker("Select Game", selection: $gameType) {
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Play with your device!").tag(GameType.bot)
                Text("Play on a single device!").tag(GameType.single)
                Text("Play with your friends via the internet!").tag(GameType.peer)
            }
            .padding()
        }
        .padding()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
