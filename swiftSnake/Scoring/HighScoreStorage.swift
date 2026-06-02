//
//  HighScoreStorage.swift
//  swiftSnake
//
//  Created by Eric Clark on 7/10/25.
//

import Foundation

//stores high score and perfomrs data operations parsing JSON 
class HighScoreStorage {
    private let key = "highScoresV2"

    func save(score: Int, initials: String) {
        var scores = load()
        scores.append(HighScoreInitials(initials: initials, score: score))
        saveAll(scores)
    }

    func load() -> [HighScoreInitials] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([HighScoreInitials].self, from: data) else {
            return []
        }
        return decoded
    }

    func saveAll(_ scores: [HighScoreInitials]) {
        if let encoded = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func delete(at offsets: IndexSet) {
        var scores = load()
        scores.sort { $0.score > $1.score }
        scores.remove(atOffsets: offsets)
        saveAll(scores)
    }
}

