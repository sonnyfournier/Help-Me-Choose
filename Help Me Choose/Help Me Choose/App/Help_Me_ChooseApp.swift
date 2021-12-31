//
//  Help_Me_ChooseApp.swift
//  Help Me Choose
//
//  Created by Sonny on 22/12/2021.
//

import SwiftUI

@main
struct Help_Me_ChooseApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView().onAppear(perform: {
                Preferences.saveWheelDefaultDecision()
            })
        }
    }
}
