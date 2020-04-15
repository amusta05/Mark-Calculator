//
//  CoursesViewController.swift
//  Mark Calculator
//
//  Created by Areeb Mustafa on 2020-04-07.
//  Copyright © 2020 Areeb Mustafa. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    
    var dict: [String: Course] = [:]
    var yCounter = 125.0
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dict.count)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1000)
        
        for (key,_) in dict{
            let button = UIButton(type:.system)
            
            button.frame = CGRect(x: 21, y: yCounter, width: 357, height: 47)
            button.backgroundColor = UIColor.systemGray6
            button.setTitle(key, for:.normal )
            button.setTitleColor(UIColorFromRGB(rgbValue: 0x137EFF), for: .normal)
            button.tintColor = .blue
            
            button.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 17.0)
            button.addTarget(self, action: #selector(self.buttonClicked), for: UIControl.Event.touchUpInside)
            self.view.addSubview(button)
            yCounter += 80
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func calculateSemAvgPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "calculateSemAvg", sender: self)
    }
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    @objc func buttonClicked(sender: UIButton){
        print("button clicked")
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
