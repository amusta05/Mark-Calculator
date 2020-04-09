//
//  ViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-06.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var weightTextField: UITextField!
    let myPickerData = [String](arrayLiteral: "0.25", "0.5", "0.75", "1.0")
    var counter = 0
    
    
    @IBOutlet weak var courseNameText: UITextField!
    
    @IBOutlet weak var courseItemText: UITextField!
    @IBOutlet weak var yourMarkTextField: UITextField!
    @IBOutlet weak var worthTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let thePicker = UIPickerView()
        thePicker.delegate = self
        weightTextField.inputView = thePicker
        courseNameText.delegate = self
        courseItemText.delegate = self
        yourMarkTextField.delegate = self
        worthTextField.delegate = self
        
        
    }


    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func calculateGradePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "calculateGrade", sender:self)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weightTextField.text = myPickerData[row]
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        courseNameText.endEditing(true)
        courseItemText.endEditing(true)
        yourMarkTextField.endEditing(true)
        worthTextField.endEditing(true)
        return true
        
    }
    
    
    
}



