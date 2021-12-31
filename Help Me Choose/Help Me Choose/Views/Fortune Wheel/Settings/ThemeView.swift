//
//  ThemeView.swift
//  Help Me Choose
//
//  Created by Sonny on 31/12/2021.
//

import SwiftUI

struct ThemeView: View {

    // MARK: - Properties
    @Binding var decision: WheelDecision
    private let themes = Constants.Themes.allThemes

    // MARK: - Views
    var body: some View {
        List {
            ForEach(themes.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 5) {
                    Text(themes[index].name)
                    ZStack {
                        HStack(spacing: 0) {
                            ForEach(themes[index].colors, id: \.self) { color in
                                ZStack {
                                    Rectangle()
                                        .fill(color)
                                        .frame(height: 80)
                                }
                            }
                        }
                        if decision.themeName == themes[index].name {
                            Rectangle()
                                .fill(Color.white.opacity(0.5))
                                .frame(height: 80)
                            Image(systemName: "checkmark")
                        }
                    }
                    .cornerRadius(10)
                }
                .padding()
                .onTapGesture { decision.themeName = themes[index].name }
            }
        }
        .navigationTitle("theme")
        .navigationBarTitleDisplayMode(.inline)
    }

}

// MARK: - Preview
struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(decision: .constant(Constants.WheelDecisions.defaultDecision))
    }
}
