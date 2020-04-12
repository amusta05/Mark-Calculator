//
//  CalculateGradeViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-06.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class CalculateGradeViewController: UIViewController {

    var viewController: ViewController = ViewController()
    var array: [Mark] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
  
    @IBAction func backButtonCalcPressed(_ sender: UIButton) {
        array.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCoursePressed(_ sender: UIButton) {
        
        // backend clear screen add to hashmap
        print("Course was added")
        self.dismiss(animated: true, completion: nil)
    }
}
