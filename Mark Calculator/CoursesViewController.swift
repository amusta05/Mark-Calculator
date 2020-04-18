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
    var yCounter = 120.0
    var yCount = 797.0
    
    var flag = 0
    @IBOutlet weak var calcAverageButton: UIButton!
    var buttonClickedStr: String!
    var button:  UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("comes here in da calc")
        print(dict.count)
        //scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1000)
        
        flag = 1
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        if flag == 1{
            print("the dict count is \(dict.count)")
            let  buttons = getButtons(view: self.view)
            //print(buttons.count)
            var i = 1
            while i < buttons.count{
                
                buttons[i].removeFromSuperview()
                i += 1
            }
            i = 0
            yCounter = 120.0
            for (key,_) in dict {
                button = UIButton(type:.system)
                
                button.frame = CGRect(x: 30, y: yCounter, width: 357, height: 47)
                button.backgroundColor = UIColor.systemGray6
                button.setTitle(key, for:.normal )
                button.setTitleColor(UIColorFromRGB(rgbValue: 0x137EFF), for: .normal)
                button.tintColor = .blue
                
                button.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 17.0)
                button.addTarget(self, action: #selector(self.buttonClicked), for: UIControl.Event.touchUpInside)
                self.view.addSubview(button)
                yCounter += 60
                print("yCounter is \(yCounter)")
                i += 1
                // COME BACK TO THIS FOR ERROR CHECKING
                if i >= 10{
                    //calcSemAvgButton.frame = CGRect(x: 34, y: yCount, width: 346, height: 62)
                    yCount += 80
                    print("yCount is \(yCount)")
                }
            }
            
        }
        
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
    
       buttonClickedStr = button.titleLabel?.text
       self.performSegue(withIdentifier:"courseInfo" , sender: self)
    }
    
    @IBAction func calcAvgButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "calculateSemAvg", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "calculateSemAvg"{
            let vc = segue.destination as! SemesterAverageViewController
            vc.map = dict
        }
        else{
            let vc  = segue.destination as!  CourseInfoViewController
            vc.map = dict
            vc.buttonClicked = buttonClickedStr
        }
       
    }
    
    func getButtons(view: UIView) -> [UIButton] {
        var results = [UIButton]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UIButton {
                results += [textField]
            } else {
                results += getButtons(view: subview)
            }
        }
        return results
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
