//
//  WheelBoltView.swift
//  Help Me Choose
//
//  Created by Sonny on 22/12/2021.
//

import SwiftUI

struct WheelBoltView: View {

    // MARK: - Properties
    var emoji: String

    // MARK: - Views
    var body: some View {
        ZStack {
            Circle().frame(width: 70, height: 70)
                .foregroundColor(Color("BoltBackground"))
            Circle().frame(width: 63, height: 63)
                .foregroundColor(Color("BoltCenter"))
                .shadow(color: Color("ShadowLight").opacity(0.35), radius: 3, x: 0.0, y: 1.0)
            Text(emoji)
                .font(.largeTitle)
        }
    }

}

// MARK: - Preview
struct WheelBoltView_Previews: PreviewProvider {
    static var previews: some View {
        WheelBoltView(emoji: "🏀")
    }
}
