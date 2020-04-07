//
//  ViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-06.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        print("button was pressed")
    }
    
    
    @IBAction func calculateGradePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "calculateGrade", sender:self)
    }
    
    
    
}



