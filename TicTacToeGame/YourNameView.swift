//
//  YourNameView.swift
//  TicTacToeGame
//
//  Created by Nikita Kolomoec on 15.03.2023.
//

import SwiftUI

struct YourNameView: View {
    
    @State private var name = ""
    
    var body: some View {
        VStack {
            Text("How we should call you?")
                .foregroundColor(.primary)
            TextField("Your Name", text: $name)
                .padding()
                .textFieldStyle(.roundedBorder)
            Button("Submit") {
                UserDefaults.standard.set(name, forKey: "yourName")
            }
            .disabled(name.isEmpty)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct YourNameView_Previews: PreviewProvider {
    static var previews: some View {
        YourNameView()
    }
}
