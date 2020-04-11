//
//  HelperMethods.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-10.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import Foundation
import UIKit
class HelperMethods {
    
    init(){
        
    }
    
  
    func createTextField(x: Double, y:Double,width:Double,height:Double,viewController:UIViewController) -> UITextField {
        
        let sampleTextField =  UITextField(frame: CGRect(x: x, y: y, width: width, height: height))
        sampleTextField.placeholder = ""
        sampleTextField.font = UIFont.systemFont(ofSize: 14)
        sampleTextField.borderStyle = UITextField.BorderStyle.line
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.backgroundColor = UIColor.systemGray5
       // sampleTextField.delegate = viewController.self as? UITextFieldDelegate
        viewController.view.addSubview(sampleTextField)
        return sampleTextField
        
    }
}
