//
//  WheelSettingsView.swift
//  Help Me Choose
//
//  Created by Sonny on 27/12/2021.
//

import SwiftUI

struct WheelSettingsView: View {

    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedDecision: WheelDecision
    @State private var showDetailsForDecision: WheelDecision? = nil
    @State private var decisions: [WheelDecision] = Preferences.retrieveWheelDecisions()

    // MARK: - Views
    var body: some View {
        List {
            ForEach(decisions, id: \.self) { decision in
                HStack {
                    Button(action: { selectedDecision(decision) }) {
                        HStack {
                            WheelSettingsListCell(decision: decision)
                            Spacer()
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    Button(action: { showDetailsForDecision = decision }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .frame(width: 25, height: 25)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }.onDelete { index in removeDecision(at: index) }
        }.fullScreenCover(item: $showDetailsForDecision) { decision in
            WheelSettingsDetailsView(decision: decision, onClose: { self.decisions = Preferences.retrieveWheelDecisions() })
        }
        .navigationTitle("decisions")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: { selectedDecision() }) {
                    Label("back", systemImage: "chevron.left")
                        .labelStyle(.titleAndIcon)
                },
            trailing:
                Button(action: { createDecision() }) { Image(systemName: "plus") }
        )
    }

    // MARK: - Actions
    private func selectedDecision(_ decision: WheelDecision? = nil) {
        if let decision = decision {
            Preferences.saveSelectedWheelDecision(decision)
            selectedDecision = decision
        } else {
            selectedDecision = Preferences.retrieveSelectedWheelDecision()
        }
        presentationMode.wrappedValue.dismiss()
    }

    private func createDecision() {
        let newDecision = WheelDecision(title: "", choices: [""])
        showDetailsForDecision = newDecision
    }

    private func removeDecision(at indexSet: IndexSet) {
        guard let idToRemove = indexSet.map({ decisions[$0].id }).first,
              let decisionToRemove = decisions.first(where: { $0.id == idToRemove }) else { return }

        decisions.removeAll(where: { $0.id == idToRemove })
        Preferences.removeWheelDecision(decisionToRemove)
    }

}

// MARK: Preview
struct WheelSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let decision = WheelDecision(title: "Decision", choices: [])
        WheelSettingsView(selectedDecision: .constant(decision))
    }
}
