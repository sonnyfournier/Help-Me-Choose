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
    @State var tap = false
    @State private var showWheelSettings = false
    private let size: CGFloat = 320

    // MARK: - Initialization
    public init() {
        let selectedDecision = Preferences.retrieveSelectedWheelDecision()
        _viewModel = StateObject(wrappedValue: FortuneWheelViewModel(decision: selectedDecision))
    }

    // MARK: - Views
    public var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: WheelSettingsView(selectedDecision: $viewModel.decision),
                               isActive: $showWheelSettings) { EmptyView() }

                Text(viewModel.decision.title)
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                ZStack(alignment: .top) {
                    ZStack(alignment: .center) {
                        WheelView(decision: viewModel.decision, selectedIndex: $viewModel.selectedIndex)
                            .frame(width: size, height: size)
                            .overlay(
                                RoundedRectangle(cornerRadius: size / 2)
                                    .stroke(lineWidth: 7)
                                    .foregroundColor(Color("WheelStroke"))
                            )
                            .rotationEffect(.degrees(viewModel.degree))
                        WheelBoltView(emoji: viewModel.decision.emoji)
                            .scaleEffect(tap ? 1.2 : 1)
                            .animation(.spring(), value: tap ? 1.2 : 1)
                            .onTapGesture {
                                tap = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { tap = false }
                                viewModel.spinWheel()
                            }
                    }
                    WheelPointerView()
                        .offset(x: 0, y: -25)
                }

                Spacer()

                Button(action: { viewModel.resetWheel() }) { Text("reset") }.padding()

                Spacer()
            }
            .navigationBarItems(
                trailing:
                    Button(action: { showSettings() }) { Image(systemName: "list.bullet") }
            )
        }
    }

    // MARK: - Actions
    private func showSettings() {
        showWheelSettings = true
        viewModel.resetWheel()
    }

}

// MARK: - Preview
struct FortuneWheelView_Previews: PreviewProvider {
    static var previews: some View {
        FortuneWheelView()
    }
}
