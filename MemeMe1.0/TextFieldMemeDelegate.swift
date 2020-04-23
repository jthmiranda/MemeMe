//
//  TextFieldMemeDelegate.swift
//  MemeMe1.0
//
//  Created by Jonathan Miranda on 4/21/20.
//  Copyright © 2020 Jonathan Miranda. All rights reserved.
//

import UIKit

class TextFieldMemeDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let oldValue = textField.text
        if oldValue == "TOP" || oldValue == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
