//
//  Constants.swift
//  Help Me Choose
//
//  Created by Sonny on 31/12/2021.
//

import Foundation

struct Constants {

    struct WheelDecisions {
        static let defaultDecision = WheelDecision(emoji: "🌴", title: localizedString(for: "next_vacation_destination"),
                                                   choices: [localizedString(for: "france"), localizedString(for: "belgium"),
                                                             localizedString(for: "netherland"), localizedString(for: "spain"),
                                                             localizedString(for: "italia"), localizedString(for: "japan"),
                                                             localizedString(for: "korea")], isSelected: true)
    }

}
