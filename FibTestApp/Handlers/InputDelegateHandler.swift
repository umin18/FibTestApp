//
//  inputDelegateHandler.swift
//  FibTestApp
//
//  Created by Eric Cha on 1/2/20.
//  Copyright © 2020 Eric Cha. All rights reserved.
//

import UIKit

protocol InputTextFieldProtocol {
    func calculateFibonacci(_ number: Int)
}

class InputDelegateHandler: NSObject, UITextFieldDelegate {
    
    var delegate : InputTextFieldProtocol?
    
    // Prevent user from entering invalid characters into the text field and limit number of characters allowed
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isFirstResponder {
            let validationString = CharacterSet(charactersIn: " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvqxyz!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢")

            if (textField.textInputMode?.primaryLanguage == "emoji") || textField.textInputMode?.primaryLanguage == nil {
                return false
            }
            if string.rangeOfCharacter(from: validationString) != nil
            {
                return false
            }
        }
        
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 2
    }
    
    // Obtain the n value and calculate fibonacci for n
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let input = textField.text, let number = Int(input) else { return }
        delegate?.calculateFibonacci(number)
    }
}
