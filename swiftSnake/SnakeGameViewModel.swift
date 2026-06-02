//
//  SnakeGameViewModel.swift
//  swiftSnake
//
//  Created by Eric Clark on 7/10/25.
//

import SwiftUI

class SnakeGameViewModel: ObservableObject {
    enum Direction {
        case up, down, left, right
    }

    struct Point: Hashable {
        var x: Int
        var y: Int
    }

    @Published var snake: [Point] = [Point(x: 5, y: 5)]
    @Published var food: Point = Point(x: 10, y: 10)
    @Published var score = 0
    @Published var isGameOver = false
    @Published var isPaused = false

    let gridSize = 20
    private var currentDirection: Direction = .right
    private var gameTimer: Timer?
    private let storage = HighScoreStorage()

    func startGame() {
        //SoundManager.shared.playBackgroundMusic()  //music
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            if !self.isPaused {
                self.moveSnake()
            }
        }
    }

    func resetGame() {
        snake = [Point(x: 5, y: 5)]
        food = Point(x: Int.random(in: 0..<gridSize), y: Int.random(in: 0..<gridSize))
        currentDirection = .right
        score = 0
        isGameOver = false
        isPaused = false
        startGame()
    }

    func togglePause() {
        isPaused.toggle()
    }

    func changeDirection(to newDirection: Direction) {
        guard !isOpposite(newDirection, currentDirection) else { return }
        currentDirection = newDirection
    }

    private func isOpposite(_ d1: Direction, _ d2: Direction) -> Bool {
        switch (d1, d2) {
        case (.up, .down), (.down, .up), (.left, .right), (.right, .left):
            return true
        default:
            return false
        }
    }

    private func moveSnake() {
        guard !isGameOver else { return }

        var newHead = snake[0]
        switch currentDirection {
        case .up:    newHead.y -= 1
        case .down:  newHead.y += 1
        case .left:  newHead.x -= 1
        case .right: newHead.x += 1
        }

        if newHead.x < 0 || newHead.x >= gridSize ||
            newHead.y < 0 || newHead.y >= gridSize ||
            snake.contains(newHead) {
            handleGameOver()
            return
        }

        snake.insert(newHead, at: 0)

        if newHead == food {
            score += 1
            //SoundManager.shared.playEffect(named: "eat")
            spawnFood()
        } else {
            snake.removeLast()
        }
    }

    private func spawnFood() {
        var newFood: Point
        repeat {
            newFood = Point(x: Int.random(in: 0..<gridSize), y: Int.random(in: 0..<gridSize))
        } while snake.contains(newFood)
        food = newFood
    }

    private func handleGameOver() {
        isGameOver = true
        //SoundManager.shared.stopBackgroundMusic()
        //SoundManager.shared.playEffect(named: "gameover")
        //storage.save(score: score)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            NotificationCenter.default.post(name: .scoreNeedsInitials, object: self.score)
        }
        gameTimer?.invalidate()
    }
}
//gameplay initials
extension Notification.Name {
    static let scoreNeedsInitials = Notification.Name("scoreNeedsInitials")
}
