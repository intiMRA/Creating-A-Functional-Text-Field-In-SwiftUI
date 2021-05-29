//
//  UITextFieldViewRepresenTable.swift
//  textfield
//
//  Created by Inti Albuquerque on 29/05/21.
//

import Foundation
import SwiftUI

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    class UITextFieldViewRepresentableCoordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        let id: TextFieldIds
        let didTapReturn: (TextFieldIds) -> Void
        init(text: Binding<String>, id: TextFieldIds, didTapReturn: @escaping (TextFieldIds) -> Void) {
            self._text = text
            self.id = id
            self.didTapReturn = didTapReturn
        }
        
        func didChangeText(_ newText: String) {
            self.text = newText
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.didTapReturn(self.id)
            return true
        }
        
    }
    
    @Binding var text: String
    let isFoused: Bool
    let placeholder: String
    let returnKeyType: UIReturnKeyType
    let id: TextFieldIds
    let didTapReturn: (TextFieldIds) -> Void
    init(text: Binding<String>, placeholder: String, isFoused: Bool, returnKeyType: UIReturnKeyType, id: TextFieldIds, didTapReturn: @escaping (TextFieldIds) -> Void) {
        self._text = text
        self.placeholder = placeholder
        self.isFoused = isFoused
        self.id = id
        self.didTapReturn = didTapReturn
        self.returnKeyType = returnKeyType
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = TextfieldWithActionHandler(frame: .zero)
        textField.delegate = context.coordinator
        
        let atttrbutes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "ComicSansMS", size: 16)!, .foregroundColor: UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)]
        
        let placeholder = NSMutableAttributedString(string: self.placeholder)
        
        placeholder.addAttributes(atttrbutes, range: _NSRange(location: 0, length: placeholder.length))
        
        textField.attributedPlaceholder = placeholder
        
        if isFoused {
            textField.becomeFirstResponder()
        }
        
        textField.setupActionHandler(actionHandler: context.coordinator.didChangeText(_:))
        textField.returnKeyType = self.returnKeyType
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = self.text
        
        if isFoused && !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else  if !isFoused {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> UITextFieldViewRepresentableCoordinator {
        UITextFieldViewRepresentableCoordinator(text: $text, id: self.id, didTapReturn: self.didTapReturn)
    }
}

class TextfieldWithActionHandler: UITextField {
    var actionHandler: ((String) -> Void)?
    
    func setupActionHandler(actionHandler: @escaping (String) -> Void) {
        self.actionHandler = actionHandler
        self.addTarget(self, action: #selector(triggerAction), for: .editingChanged)
    }
    
    @objc
    func triggerAction() {
        self.actionHandler?(self.text ?? "")
    }
}
