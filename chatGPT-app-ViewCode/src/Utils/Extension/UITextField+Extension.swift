//
//  UITextField+Extension.swift
//  AppAlcool-Gasolina
//
//  Created by ALYSSON DODO on 18/02/23.
//

import Foundation
import UIKit

extension UITextField {
    func addDoneButtonOnKeyboard(){
        let doneToobar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToobar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(doneButtonAction))
        
        let items = [ flexSpace, done]
        doneToobar.items = items
        
        doneToobar.sizeToFit()
        self.inputAccessoryView = doneToobar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
}
