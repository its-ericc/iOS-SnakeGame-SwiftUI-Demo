//
//  ContentView.swift
//  swiftSnake
//
//  Created by Eric Clark on 7/10/25.
//

import SwiftUI

struct SnakeGameView: View {
    @StateObject private var game = SnakeGameViewModel()
    @State private var showingInitialsPrompt = false
    @State private var newScore = 0
    @State private var playerInitials = ""
   
    //private var playerInitials: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("Score: \(game.score)")
                    .font(.title)
                Spacer()
                
                //pause button on game view
                Button(action: {
                    game.togglePause()
                }) {
                    Image(systemName: game.isPaused ? "play.fill" : "pause.fill")
                        .imageScale(.large)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)

            //Board Setup
            GeometryReader { geometry in
                let size = min(geometry.size.width, geometry.size.height)
                let cellSize = size / CGFloat(game.gridSize)
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: size, height: size)
                        .border(Color.blue, width: 1)

                    ForEach(game.snake, id: \.self) { segment in
                        Rectangle()
                            .fill(Color.green) //snake color
                            .frame(width: cellSize, height: cellSize)
                            .position(x: CGFloat(segment.x) * cellSize + cellSize / 2,
                                      y: CGFloat(segment.y) * cellSize + cellSize / 2)
                    }

                    Rectangle()
                        .fill(Color.red)
                        .frame(width: cellSize, height: cellSize)
                        .position(x: CGFloat(game.food.x) * cellSize + cellSize / 2,
                                  y: CGFloat(game.food.y) * cellSize + cellSize / 2)

                    if game.isGameOver {
                        Color.black.opacity(0.6)
                            .frame(width: size, height: size)
                            .overlay(
                                VStack(spacing: 20) {
                                    Text("Game Over")
                                        .font(.largeTitle)
                                        .foregroundColor(.red)

                                    Button("New Game") {
                                        game.resetGame()
                                    }
                                    .buttonStyle(.borderedProminent)

                                    NavigationLink("View High Scores", destination: HighScoresView())
                                        .buttonStyle(.bordered)
                                }
                            )
                    }
                }
                .frame(width: size, height: size)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Arrow Controls (fixed layout to avoid distortion)
            HStack(spacing: 30) {
                Button {
                    game.changeDirection(to: .left)
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                .frame(width: 90)

                //Hard coded control buttons for control of snake (game screen)
                VStack(spacing: 20) {
                    Button {
                        game.changeDirection(to: .up)
                    } label: {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }

                    Button {
                        game.changeDirection(to: .down)
                    } label: {
                        Image(systemName: "arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .frame(width: 90)

                Button {
                    game.changeDirection(to: .right)
                } label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                .frame(width: 90)
            }
            .padding()
        }
        .onAppear {
            //the delegate lock
            game.startGame()
            NotificationCenter.default.addObserver(forName: .scoreNeedsInitials, object: nil, queue: .main) { notif in
                if let score = notif.object as? Int {
                    newScore = score
                    showingInitialsPrompt = true
                }
            }
        }
        //the game has ended enter your intials sheet overlay
        .sheet(isPresented: $showingInitialsPrompt) {
            VStack(spacing: 20) {
                //Text("New High Score!")
                Text("Your score was \(game.score)")
                    .font(.headline)
                Text("Enter your initials:")
                TextField("ABC", text: $playerInitials)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.characters)
                    .onChange(of: game.isGameOver) { isGameOver, _ in
                        if isGameOver && game.score > 0 {
                            showingInitialsPrompt = true
                        }
                    }

                Button("Save") {
                    HighScoreStorage().save(score: newScore, initials: playerInitials)
                    showingInitialsPrompt = false
                }
                .disabled(playerInitials.isEmpty)
            }
            .padding()
            .presentationDetents([.fraction(0.3)])
        }
    }
}

#Preview {
    SnakeGameView()
}
