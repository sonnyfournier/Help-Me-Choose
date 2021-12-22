//
//  TabBarView.swift
//  Help Me Choose
//
//  Created by Sonny on 22/12/2021.
//

import SwiftUI

struct TabBarView: View {

    // MARK: - Properties
    private let titles = ["Paris", "Berlin", "New-York", "Barcelone", "Rome", "Casablanca", "Bruxelles", "Tokyo"]
    @State var selectedValue: Int? = nil

    // MARK: - Views
    var body: some View {
        TabView() {
            VStack {
                FortuneWheelView(titles: titles, size: 320, onSpinEnd: { value in selectedValue = value })
                Text(selectedValue != nil ? "Wheel stopped on: \(titles[selectedValue!])" : " ").padding()
            }.tabItem { Text("Wheel") }.tag(1)

            Text("Tab 2")
                .tabItem { Text("Flip") }.tag(2)
        }
    }

}

// MARK: - Preview
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
