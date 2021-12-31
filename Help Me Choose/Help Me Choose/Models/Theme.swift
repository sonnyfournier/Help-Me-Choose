//
//  Theme.swift
//  Help Me Choose
//
//  Created by Sonny on 31/12/2021.
//

import SwiftUI

struct Theme {

    // MARK: - Properties
    let name: String
    let colors: [Color]
    let pointerColor: Color
    let strokeColor: Color

    // MARK: - Initialization
    init(name: String, colorNames: [String], pointerColorName: String, strokeColorName: String) {
        self.name = name
        self.colors = colorNames.compactMap({ Color($0) })
        self.pointerColor = Color(pointerColorName)
        self.strokeColor = Color(strokeColorName)
    }

}
