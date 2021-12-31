//
//  WheelSettingsDetailsView.swift
//  Help Me Choose
//
//  Created by Sonny on 27/12/2021.
//

import SwiftUI

struct WheelSettingsDetailsView: View {

    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @State var decision: WheelDecision
    private let initialDecision: WheelDecision
    @State var autoWeight: Bool = false
    var onClose: (() -> ())? = nil
    @State var showUnsavedChangesSheet = false

    // MARK: - Initialization
    init(decision: WheelDecision, onClose: (() -> ())? = nil) {
        _decision = State(wrappedValue: decision)
        self.initialDecision = decision
        self.onClose = onClose
    }

    // MARK: - Views
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    buildTitleSection()

                    buildChoicesSection()

                    Section("theme") { NavigationLink("theme", destination: ThemeView(decision: $decision)) }
                }
            }
            .confirmationDialog("Change background", isPresented: $showUnsavedChangesSheet) {
                Button("save_modifications") { save() }
                Button("ignore_modifications", role: .destructive) { close() }
                Button("cancel", role: .cancel) {}
            }
            .navigationTitle("decision")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: { cancel() }) { Text("cancel") },
                trailing:
                    Button(action: { save() }) { Text("save").fontWeight(.bold) }
            )
        }
    }

    @ViewBuilder func buildTitleSection() -> some View {
        Section(header: Text("decision_title")) {
            HStack {
                EmojiTextField(text: $decision.emoji, placeholder: "🤔")
                    .onReceive(decision.emoji.publisher.collect()) {
                        // TODO: Fix this for emoji that takes two "slots"
                        guard let text = Unicode.Scalar(String($0.suffix(1))), text.properties.isEmoji else {
                            decision.emoji = String(decision.emoji.prefix(1))
                            return
                        }
                        decision.emoji = String($0.suffix(1))
                    }
                    .accentColor(Color(UIColor.secondarySystemBackground))
                    .multilineTextAlignment(.center)
                    .frame(width: 30, height: 30, alignment: .center)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5)
                    .offset(x: -9, y: 0)
                TextField("title", text: $decision.title)
                    .offset(x: -10, y: 0)
            }
        }
    }

    @ViewBuilder func buildChoicesSection() -> some View {
        Section(header: Text("choices")) {
            List {
                ForEach(decision.choices.indices, id: \.self) { index in
                    HStack {
                        ThemeService.getTheme(from: decision.themeName)
                            .colors[index % ThemeService.getTheme(from: decision.themeName).colors.count]
                            .frame(width: 3)
                            .cornerRadius(1.5)
                        TextField("choice", text: $decision.choices[index])
                        Button(action: { removeChoice(at: index) }, label: {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .padding(5)
                                .frame(width: 25, height: 25)
                        })
                            .disabled(decision.choices.count < 2)
                            .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            Button(action: { addChoice() }) { Text("add_a_choice") }
        }
    }

    // MARK: - Actions
    private func addChoice() {
        if !decision.choices.contains("") {
            decision.choices.append("")
            decision.weights.append(1)
        }
    }

    private func removeChoice(at index: Int) {
        decision.choices.remove(at: index)
        decision.weights.remove(at: index)
    }

    private func save() {
        // TODO: Show error
        if decision.title.isEmpty || decision.choices.isEmpty {
            close()
            return
        }

        Preferences.saveWheelDecision(decision)
        close()
    }

    private func cancel() {
        if initialDecision != decision {
            showUnsavedChangesSheet = true
            return
        }

        close()
    }

    private func close() {
        presentationMode.wrappedValue.dismiss()
        onClose?()
    }

}

// MARK: - Preview
struct WheelSettingsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WheelSettingsDetailsView(decision: Constants.WheelDecisions.defaultDecision)
    }
}
