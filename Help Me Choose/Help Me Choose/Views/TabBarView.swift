//
//  TabBarView.swift
//  Help Me Choose
//
//  Created by Sonny on 22/12/2021.
//

import SwiftUI

struct TabBarView: View {

    // MARK: - Properties
    @State var selectedValue: Int? = nil

    // MARK: - Views
    var body: some View {
        TabView() {
            FortuneWheelView()
                .tabItem { Text("wheel") }.tag(1)
        }
    }

}

// MARK: - Preview
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
