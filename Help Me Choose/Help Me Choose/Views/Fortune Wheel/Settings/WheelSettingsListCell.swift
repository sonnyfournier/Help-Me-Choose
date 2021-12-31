//
//  WheelSettingsListCell.swift
//  Help Me Choose
//
//  Created by Sonny on 27/12/2021.
//

import SwiftUI

struct WheelSettingsListCell: View {

    // MARK: - Properties
    var decision: WheelDecision

    // MARK: - Views
    var body: some View {
        HStack {
            if decision.isSelected {
                ThemeService.getTheme(from: decision.themeName).pointerColor
                    .frame(width: 3)
                    .cornerRadius(1.5)
            }
            VStack(alignment: .leading) {
                Text("\(decision.emoji) \(decision.title)")
                    .foregroundColor(Color(uiColor: UIColor.label))
                Text(String(format: NSLocalizedString("number_choices", comment: ""), decision.choices.count))
                    .font(.callout)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5.0)
    }

}

// MARK: - Preview
struct WheelSettingsListCell_Previews: PreviewProvider {
    static var previews: some View {
        WheelSettingsListCell(decision: Constants.WheelDecisions.defaultDecision)
    }
}
