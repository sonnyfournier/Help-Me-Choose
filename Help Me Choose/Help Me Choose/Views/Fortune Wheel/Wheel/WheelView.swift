//
//  WheelView.swift
//  Help Me Choose
//
//  Created by Sonny on 22/12/2021.
//

import SwiftUI

struct WheelView: View {

    // MARK: Properties
    var labels: [String]
    var weights: [Double]
    @Binding var selectedIndex: Int?
    private let sliceOffset: Double = -.pi / 2
    private let colors: [Color] = [Color("Wheel1"), Color("Wheel2"), Color("Wheel3"), Color("Wheel4"), Color("Wheel5"),
                                   Color("Wheel6"), Color("Wheel7"), Color("Wheel8"), Color("Wheel9"), Color("Wheel10")]

    // MARK: - Initialization
    init(decision: WheelDecision, selectedIndex: Binding<Int?> = .constant(nil)) {
        self.labels = decision.choices
        self.weights = decision.weights.map({ Double((Int($0) * 100) / decision.choices.count) })
        self._selectedIndex = selectedIndex
    }

    // MARK: - Views
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                ForEach(labels.indices, id: \.self) { index in
                    WheelCell(startAngle: startAngle(for: index), endAngle: endAngle(for: index))
                        .fill(colors[index % colors.count])
                    Text(labels[index]).foregroundColor(Color.white).fontWeight(.bold)
                        .shadow(color: Color("ShadowLight").opacity(0.35), radius: 3, x: 0.0, y: 1.0)
                        .rotationEffect(textRotation(for: index, in: geo.size))
                        .offset(viewOffset(for: index, in: geo.size)).zIndex(1)
                    WheelCell(startAngle: startAngle(for: index), endAngle: endAngle(for: index))
                        .fill(Color("ShadowDark"))
                        .opacity(getOpacity(for: index))
                        .animation(.easeInOut, value: getOpacity(for: index))
                }
            }
        }
    }

    // MARK: - Functions
    private func startAngle(for index: Int) -> Double {
        switch index {
        case 0:
            return sliceOffset
        default:
            let ratio: Double = weights[..<index].reduce(0.0, +) / weights.reduce(0.0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }

    private func endAngle(for index: Int) -> Double {
        switch index {
        case weights.count - 1:
            return sliceOffset + 2 * .pi
        default:
            let ratio: Double = weights[..<(index + 1)].reduce(0.0, +) / weights.reduce(0.0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }

    private func viewOffset(for index: Int, in size: CGSize) -> CGSize {
        let radius = min(size.width, size.height) / 3.3
        let dataRatio = (2 * weights[..<index].reduce(0, +) + weights[index]) / (2 * weights.reduce(0, +))
        let angle = CGFloat(sliceOffset + 2 * .pi * dataRatio)

        return CGSize(width: radius * cos(angle), height: radius * sin(angle))
    }

    private func textRotation(for index: Int, in size: CGSize) -> Angle {
        let dataRatio = (2 * weights[..<index].reduce(0, +) + weights[index]) / (2 * weights.reduce(0, +))
        let angle = CGFloat(sliceOffset + 2 * .pi * dataRatio)

        return Angle(radians: angle)
    }

    private func getOpacity(for index: Int) -> Double {
        return (selectedIndex == index || selectedIndex == nil) ? 0 : 0.7
    }

}

// MARK: - Preview
struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        WheelView(decision: Constants.WheelDecisions.defaultDecision)
    }
}
