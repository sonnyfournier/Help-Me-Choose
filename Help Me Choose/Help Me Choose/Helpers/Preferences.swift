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
        static let wheelDecisionsKey = "WHEEL_DECISIONS"
        static let selectedWheelDecisionKey = "SELECTED_DECISION"
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

    static func retrieveWheelDecisions() -> [WheelDecision] {
        if let savedDecisions = UserDefaults.standard.object(forKey: Keys.wheelDecisionsKey) as? Data {
            if var decodedDecisions = try? JSONDecoder().decode([WheelDecision].self, from: savedDecisions) {
                var sortedDecisions: [WheelDecision] = []
                let savedSelectedDecision = retrieveSelectedWheelDecision()
                if let selectedDecisionIndex = decodedDecisions.firstIndex(where: { $0.id == savedSelectedDecision.id }) {
                    let selectedDecision = decodedDecisions.remove(at: selectedDecisionIndex)
                    sortedDecisions.append(selectedDecision)
                }
                sortedDecisions.append(contentsOf: decodedDecisions)
                return sortedDecisions
            }
        }

        return []
    }

    static func removeWheelDecision(_ decision: WheelDecision) {
        var savedDecisions = retrieveWheelDecisions()
        savedDecisions.removeAll(where: { $0.id == decision.id })
        UserDefaults.standard.set([], forKey: Keys.wheelDecisionsKey)
        for decision in savedDecisions { saveWheelDecision(decision) }
    }

    // MARK: - Selected wheel decision
    static func saveSelectedWheelDecision(_ decision: WheelDecision) {
        if let encoded = try? JSONEncoder().encode(decision) {
            UserDefaults.standard.set(encoded, forKey: Keys.selectedWheelDecisionKey)
        }
    }

    static func retrieveSelectedWheelDecision() -> WheelDecision {
        if let savedDecision = UserDefaults.standard.object(forKey: Keys.selectedWheelDecisionKey) as? Data {
            if let decodedDecision = try? JSONDecoder().decode(WheelDecision.self, from: savedDecision) {
                return decodedDecision
            }
        }

        return retrieveDefaultWheelDecision()
    }

    static private func retrieveDefaultWheelDecision() -> WheelDecision {
        let defaultDecision = WheelDecision(title: "Vacances", choices: ["Italie", "Bretagne", "Norvège", "Luxembourg", "Chypre"])
        saveSelectedWheelDecision(defaultDecision)
        return defaultDecision
    }

}
