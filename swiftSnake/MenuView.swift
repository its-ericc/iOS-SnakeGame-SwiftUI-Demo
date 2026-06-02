//
//  MenuView.swift
//  swiftSnake
//
//  Created by Eric Clark on 7/10/25.
//

import SwiftUI

struct MenuView: View {
    
    @State private var playGame = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Eric's 🐍 Snake Game") //App Title main menu
                    .font(.largeTitle)
                    .bold()

                NavigationLink("Start Game", destination: SnakeGameView())
                    .buttonStyle(MenuButtonStyle())
                
              
         
                NavigationLink("High Scores", destination: HighScoresView())
                    .buttonStyle(MenuButtonStyle())

                NavigationLink("Contact", destination: ContactView())
                    .buttonStyle(MenuButtonStyle())
            }
            .padding()

        }
    }
}

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green.opacity(configuration.isPressed ? 0.6 : 0.8)) //green and white look sharp on display dark mode & light
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}

#Preview {
    MenuView()
}
