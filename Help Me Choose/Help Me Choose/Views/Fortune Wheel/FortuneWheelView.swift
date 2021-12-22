//
//  FortuneWheelView.swift
//  Help Me Choose
//
//  Created by Sonny on 22/12/2021.
//

import SwiftUI

struct FortuneWheelView: View {

    // MARK: - Properties
    @StateObject var viewModel: FortuneWheelViewModel
    var titles: [String]
    var size: CGFloat
    var onSpinEnd: ((Int) -> ())? = nil

    // MARK: - Initialization
    public init(titles: [String], size: CGFloat, onSpinEnd: ((Int) -> ())? = nil) {
        self.titles = titles
        self.size = size

        _viewModel = StateObject(wrappedValue: FortuneWheelViewModel(titles: titles, onSpinEnd: onSpinEnd))
    }

    // MARK: - Views
    public var body: some View {
        VStack {
            ZStack(alignment: .top) {
                ZStack(alignment: .center) {
                    WheelView(labels: titles, selectedIndex: $viewModel.selectedIndex)
                        .frame(width: size, height: size)
                        .overlay(
                            RoundedRectangle(cornerRadius: size / 2)
                                .stroke(lineWidth: 7)
                                .foregroundColor(Color("WheelStroke"))
                        )
                        .rotationEffect(.degrees(viewModel.degree))
                    WheelBoltView()
                        .onTapGesture { viewModel.spinWheel() }
                }
                WheelPointerView()
                    .offset(x: 0, y: -25)
            }
            Button(action: { viewModel.selectedIndex = nil }) {
                Text("Reset")
            }.padding()
        }
    }

}

// MARK: - Preview
struct FortuneWheelView_Previews: PreviewProvider {
    static var previews: some View {
        FortuneWheelView(titles: ["Paris", "Berlin", "New-York", "Barcelone", "Rome", "Casablanca", "Bruxelles", "Tokyo"],
                         size: 320)
    }
}
