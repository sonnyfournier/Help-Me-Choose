//
//  Preferences.swift
//  Help Me Choose
//
//  Created by Sonny on 27/12/2021.
//

import Foundation

// MARK: - Keys
extension Preferences {
    struct Keys {
        static let wheelDecisionsKey = "WHEEL_DECISIONS_KEY"
        static let wheelDefaultDecisionsKey = "WHEEL_DEFAULT_DECISION_KEY"
    }
}

class Preferences {

    // MARK: - Wheel decisions
    static func saveWheelDecision(_ decision: WheelDecision) {
        var savedDecisions = retrieveWheelDecisions()
        savedDecisions.removeAll(where: { $0.id == decision.id })
        var decision = decision
        decision.choices.removeAll(where: { $0.isEmpty })
        savedDecisions.append(decision)

        if let encoded = try? JSONEncoder().encode(savedDecisions) {
            UserDefaults.standard.set(encoded, forKey: Keys.wheelDecisionsKey)
        }
    }

    static func saveAllWheelDecisions(_ decisions: [WheelDecision]) {
        if let encoded = try? JSONEncoder().encode(decisions) {
            UserDefaults.standard.set(encoded, forKey: Keys.wheelDecisionsKey)
        }
    }

    static func retrieveWheelDecisions() -> [WheelDecision] {
        if let savedDecisions = UserDefaults.standard.object(forKey: Keys.wheelDecisionsKey) as? Data {
            if let decodedDecisions = try? JSONDecoder().decode([WheelDecision].self, from: savedDecisions) {
                return decodedDecisions.sorted(by: { $0.isSelected && !$1.isSelected })
            }
        }

        return []
    }

    static func removeWheelDecision(_ decision: WheelDecision) {
        var savedDecisions = retrieveWheelDecisions()
        savedDecisions.removeAll(where: { $0.id == decision.id })
        saveAllWheelDecisions(savedDecisions)
    }

    // MARK: - Selected wheel decision
    static func saveSelectedWheelDecision(_ decision: WheelDecision) {
        var decisions = Preferences.retrieveWheelDecisions()
        for index in decisions.indices {
            decisions[index].isSelected = decisions[index].id == decision.id
        }
        saveAllWheelDecisions(decisions)
    }

    static func retrieveSelectedWheelDecision() -> WheelDecision {
        let decisions = Preferences.retrieveWheelDecisions()

        if let selectedDecision = decisions.first(where: { $0.isSelected }) {
            return selectedDecision
        } else if let firstDecision = decisions.first {
            saveSelectedWheelDecision(firstDecision)
            return firstDecision
        } else {
            return Constants.WheelDecisions.defaultDecision
        }
    }

    // MARK: - Wheel default decision
    static func saveWheelDefaultDecision() {
        if !retrieveWheelDefaultDecisionSetted() {
            saveAllWheelDecisions([Constants.WheelDecisions.defaultDecision])
            UserDefaults.standard.set(true, forKey: Keys.wheelDefaultDecisionsKey)
        }
    }

    static func retrieveWheelDefaultDecisionSetted() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.wheelDefaultDecisionsKey)
    }

}
