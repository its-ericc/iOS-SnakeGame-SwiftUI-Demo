//
//  HighScoresView.swift
//  swiftSnake
//
//  Created by Eric Clark on 7/10/25.
//

import SwiftUI

struct HighScoresView: View {
    @State private var scores: [HighScoreInitials] = []  //high score object stores score and name
    private let storage = HighScoreStorage()

    var body: some View {
        VStack(spacing: 10) {
            Text("🏆 High Scores")
                .font(.largeTitle)
                .padding(.top)

            if scores.isEmpty {
                Text("No scores yet.")
            } else {
                List {
                    ForEach(Array(scores.enumerated()), id: \.element) { index, entry in
                        HStack {
                            if index == 0 {             //based on index assigns medals to top 3
                                Text("🥇")
                            } else if index == 1 {
                                Text("🥈")
                            } else if index == 2 {
                                Text("🥉")
                            }

                            Text("\(entry.initials.uppercased())")
                                .fontWeight(.bold)
                                .frame(width: 50, alignment: .leading)

                            Spacer()

                            Text("Score: \(entry.score)")
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteScore)
                }
                .listStyle(.insetGrouped)
            }
        }
        .onAppear {
            scores = storage.load().sorted { $0.score > $1.score }
        }
        .padding()
    }

    private func deleteScore(at offsets: IndexSet) {
        scores.remove(atOffsets: offsets)
        storage.saveAll(scores)
    }
}



