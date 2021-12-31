//
//  EmojiTextField.swift
//  Help Me Choose
//
//  Created by Sonny on 31/12/2021.
//

import SwiftUI

// MARK: - UIEmojiTextField
class UIEmojiTextField: UITextField {

    // MARK: - Properties
    override var textInputContextIdentifier: String? { return "" }

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default
                return mode
            }
        }

        return nil
    }

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Functions
    func setEmoji() {
        _ = self.textInputMode
    }

}

// MARK: - EmojiTextField
struct EmojiTextField: UIViewRepresentable {

    // MARK: - Properties
    @Binding var text: String
    var placeholder: String = ""

    // MARK: - Functions
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.textAlignment = .center
        emojiTextField.delegate = context.coordinator

        return emojiTextField
    }

    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, UITextFieldDelegate {

        var parent: EmojiTextField

        init(parent: EmojiTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }

    }

}

// MARK: - Preview
struct EmojiTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmojiTextField(text: .constant("🎲"))
    }
}
