//
//  MPpeersView.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 15.03.2023.
//

import SwiftUI

struct MPpeersView: View {
    
    @EnvironmentObject var game: GameServise
    @EnvironmentObject var connectionManager: MPConnectionManager
    @Binding var startGame: Bool
    
    var body: some View {
        VStack {
            Text("Available players")
            List(connectionManager.availablePeers, id: \.self) { peer in
                HStack {
                    Text(peer.displayName)
                    Spacer()
                    Button("Select") {
                        game.gameType = .peer
                        connectionManager.nearbyServiceBrowser.invitePeer(peer, to: connectionManager.session, withContext: nil, timeout: 40)
                        game.player1.name = connectionManager.myPeerId.displayName
                        game.player2.name = peer.displayName
                    }
                    .buttonStyle(.borderedProminent)
                }
                .alert("Recieved Invitation from \(connectionManager.recieveInviteForm?.displayName ?? "Unknown")", isPresented: $connectionManager.recieveInvites) {
                    Button("Accept") {
                        if let invitationHandler = connectionManager.invitationHandler {
                            invitationHandler(true, connectionManager.session)
                            game.player1.name = connectionManager.recieveInviteForm?.displayName ?? "Unknown"
                            game.player2.name = connectionManager.myPeerId.displayName
                            game.gameType = .peer
                        }
                    }
                    Button("Reject") {
                        if let invitationHandler = connectionManager.invitationHandler {
                            invitationHandler(false, nil)
                        }
                    }
                }

            }
        }
        .onAppear {
            connectionManager.isAvailableToPlay = true
            connectionManager.startBrowser()
        }
        .onDisappear {
            connectionManager.endAdvert()
            connectionManager.endBrowser()
            connectionManager.isAvailableToPlay = false
        }
        .onChange(of: connectionManager.paired) { newValue in
            startGame = newValue
        }
    }
}

struct MPpeersView_Previews: PreviewProvider {
    static var previews: some View {
        MPpeersView(startGame: .constant(false))
            .environmentObject(GameServise())
            .environmentObject(MPConnectionManager(yourName: "name1"))
    }
}
