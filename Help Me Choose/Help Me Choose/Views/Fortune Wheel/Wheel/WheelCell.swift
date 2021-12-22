//
//  WheelCell.swift
//  Help Me Choose
//
//  Created by Sonny on 22/12/2021.
//

import SwiftUI

struct WheelCell: Shape {

    // MARK: - Properties
    let startAngle: Double
    let endAngle: Double

    // MARK: - Functions
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        let alpha = CGFloat(startAngle)
        let center = CGPoint(x: rect.midX, y: rect.midY)

        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x + cos(alpha) * radius, y: center.y + sin(alpha) * radius))
        path.addArc(center: center, radius: radius, startAngle: Angle(radians: startAngle),
                    endAngle: Angle(radians: endAngle), clockwise: false)
        path.closeSubpath()
        return path
    }
}

// MARK: - Preview
struct WheelCell_Previews: PreviewProvider {
    static var previews: some View {
        WheelCell(startAngle: 0, endAngle: 0.5)
    }
}
