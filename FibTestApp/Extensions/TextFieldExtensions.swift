//
//  TextFieldExtensions.swift
//  FibTestApp
//
//  Created by Eric Cha on 1/2/20.
//  Copyright © 2020 Eric Cha. All rights reserved.
//

import UIKit

extension UITextField {

    func addDoneButtonOnKeyboard() {
       let keyboardToolbar = UIToolbar()
       keyboardToolbar.sizeToFit()
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
           target: nil, action: nil)
       let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
           target: self, action: #selector(resignFirstResponder))
       keyboardToolbar.items = [flexibleSpace, doneButton]
       self.inputAccessoryView = keyboardToolbar
    }
}
