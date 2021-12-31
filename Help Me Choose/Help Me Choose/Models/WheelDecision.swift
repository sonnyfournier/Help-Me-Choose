//
//  WheelDecision.swift
//  Help Me Choose
//
//  Created by Sonny on 27/12/2021.
//

import Foundation

struct WheelDecision: Identifiable, Hashable, Codable {

    let id: UUID
    var emoji: String
    var title: String
    var choices: [String]
    var weights: [Double]

    init(emoji: String? = nil, title: String, choices: [String], weights: [Double]? = nil) {
        self.id = UUID()
        self.emoji = emoji ?? "🤔"
        self.title = title
        self.choices = choices
        self.weights = weights ?? Array(repeating: 1, count: choices.count)
    }

}
