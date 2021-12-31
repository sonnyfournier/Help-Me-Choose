//
//  Constants.swift
//  Help Me Choose
//
//  Created by Sonny on 31/12/2021.
//

import Foundation

struct Constants {

    // MARK: - Wheel decisions
    struct WheelDecisions {
        static let defaultDecision = WheelDecision(emoji: "🌴", title: localizedString(for: "next_vacation_destination"),
                                                   choices: [localizedString(for: "france"), localizedString(for: "belgium"),
                                                             localizedString(for: "netherland"), localizedString(for: "spain"),
                                                             localizedString(for: "italia"), localizedString(for: "japan"),
                                                             localizedString(for: "korea"), localizedString(for: "corsica"),
                                                             localizedString(for: "germany"), localizedString(for: "uk"),
                                                             localizedString(for: "denmark"), localizedString(for: "poland")],
                                                   isSelected: true)
    }

    // MARK: - Themes
    struct Themes {
        static let spring = Theme(name: "Spring",
                                  colorNames: ["Spring-1", "Spring-2", "Spring-3", "Spring-4", "Spring-5", "Spring-6"],
                                  pointerColorName: "Spring-1", strokeColorName: "SpringStroke")
        static let summer = Theme(name: "Summer",
                                  colorNames: ["Summer-1", "Summer-2", "Summer-3", "Summer-4", "Summer-5", "Summer-6"],
                                  pointerColorName: "Summer-4", strokeColorName: "SummerStroke")
        static let autumn = Theme(name: "Autumn",
                                  colorNames: ["Autumn-1", "Autumn-2", "Autumn-3", "Autumn-4", "Autumn-5", "Autumn-6"],
                                  pointerColorName: "Autumn-6", strokeColorName: "AutumnStroke")
        static let winter = Theme(name: "Winter",
                                  colorNames: ["Winter-1", "Winter-2", "Winter-3", "Winter-4", "Winter-5", "Winter-6"],
                                  pointerColorName: "Winter-2", strokeColorName: "WinterStroke")
        static let bright = Theme(name: "Bright",
                                  colorNames: ["Bright-1", "Bright-2", "Bright-3", "Bright-4", "Bright-5", "Bright-6"],
                                  pointerColorName: "Bright-1", strokeColorName: "BrightStroke")
        static let allThemes = [Themes.spring, Themes.summer, Themes.autumn, Themes.winter, Themes.bright]
    }

}
