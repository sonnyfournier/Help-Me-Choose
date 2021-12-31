//
//  FortuneWheelViewModel.swift
//  Help Me Choose
//
//  Created by Sonny on 22/12/2021.
//

import SwiftUI

class FortuneWheelViewModel: ObservableObject {

    // MARK: - Properties
    @Published var decision: WheelDecision
    @Published var degree = 0.0
    @Published var selectedIndex: Int?
    private var pendingRequestWorkItem: DispatchWorkItem?

    // MARK: - Initialization
    init(decision: WheelDecision) {
        self.decision = decision
    }

    // MARK: - Functions
    func spinWheel() {
        selectedIndex = nil
        let random = Double.random(in: 720...7200)
        let animationDuration = Double(5)
        let animation = Animation.timingCurve(0.51, 0.97, 0.56, 0.99, duration: animationDuration)
        withAnimation(animation) {  [weak self] in self?.degree += random }

        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()

        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }

            let distance = self.degree.truncatingRemainder(dividingBy: 360)
            let pointer = floor(distance / (360 / Double(self.decision.choices.count)))

            let index = self.decision.choices.count - Int(pointer) - 1
            self.selectedIndex = index
        }

        // Save the new work item and execute it after duration
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + 1, execute: requestWorkItem)
    }

    func resetWheel() {
        selectedIndex = nil
        let roundedDegree = Double(360 * Int(degree / 360))
        withAnimation(.easeInOut) { [weak self] in self?.degree = roundedDegree }
    }

}
