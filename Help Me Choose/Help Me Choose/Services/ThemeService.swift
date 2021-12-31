//
//  ThemeService.swift
//  Help Me Choose
//
//  Created by Sonny on 31/12/2021.
//

import Foundation

class ThemeService {

    static func getTheme(from name: String?) -> Theme {
        switch name {
        case "Spring":
            return Constants.Themes.spring
        case "Summer":
            return Constants.Themes.summer
        case "Autumn":
            return Constants.Themes.autumn
        case "Winter":
            return Constants.Themes.winter
        case "Bright":
            return Constants.Themes.bright
        default:
            return Constants.Themes.autumn
        }
    }

}
