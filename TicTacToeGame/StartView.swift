//
//  ContentView.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 14.03.2023.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var game: GameServise
    @AppStorage("yourName") var yourName = ""
    @State private var gameType: GameType = .undetermined
    @State private var opponentName = ""
    @FocusState private var focus: Bool
    @State private var startGame = false
    @State private var changeName = false
    @State private var newName = ""
    
    init(yourName: String) {
        self.yourName = yourName
    }
    var body: some View {
        VStack {
            Picker("Select Game", selection: $gameType) {
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Play with your device!").tag(GameType.bot)
                Text("Play on a single device!").tag(GameType.single)
                Text("Play with your friends via the internet!").tag(GameType.peer)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2)
            )
            Text(gameType.description)
                .padding()
            VStack {
                switch gameType {
                case .single:
                    TextField("Opponents Name", text: $opponentName)
                case .bot:
                    EmptyView()
                case .peer:
                    EmptyView()
                case .undetermined:
                    EmptyView()
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width: 350)
            if gameType != .peer {
                Button("Start the game!") {
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                    focus = false
                    startGame.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    gameType == .undetermined ||
                    gameType == .single && opponentName.isEmpty
                )
                Image("LaunchScreen")
                Text("Your Name is \(yourName)")
                Button("Change my name") {
                    changeName.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Tic Tac Toe Game")
        .fullScreenCover(isPresented: $startGame){
            GameView()
        }
        .alert("Change Name", isPresented: $changeName, actions: {
            TextField("New Name", text: $newName)
            Button("OK", role: .destructive) {
                yourName = newName
                exit(-1)
            }
            Button("Cancel", role: .cancel) {}
        }, message: {
            Text("Tapping on the OK Button will change your name and reload your app, to apply changes")
        })
        .isNavStack()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(yourName: "Iphone Name")
            .environmentObject(GameServise())
    }
}
