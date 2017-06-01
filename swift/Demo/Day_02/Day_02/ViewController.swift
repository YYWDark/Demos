//
//  ViewController.swift
//  Day_02
//
//  Created by wyy on 2017/6/1.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var scrollView: UIScrollView?
    var button: UIButton?
    var textfield: UITextField?
    var label: UILabel?
    var switchControl: UISwitch?
    var pickView: UIDatePicker?
    var segment: UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button = UIButton.init(type: .system)
        button?.setTitle("按钮", for: .normal)
        button?.backgroundColor = UIColor.init(red: 1, green: 1, blue: 0.3, alpha: 1)
        button?.addTarget(self, action:#selector(respondsToButtonAction(sender:)), for:.touchUpInside)
        self.view.addSubview(button!)
        
        textfield = UITextField.init()
        textfield?.delegate = self
        textfield?.layer.borderWidth = 1.0
        textfield?.layer.borderColor = UIColor.init(white: 0, alpha: 0).cgColor
        self.view.addSubview(textfield!)
        
        label = UILabel.init()
        label?.text = "文本"
        self.view.addSubview(label!)
        
        switchControl = UISwitch.init()
        self.view.addSubview(switchControl!)
        
        segment = UISegmentedControl.init()
        self.view.addSubview(segment!)
        
        pickView = UIDatePicker.init()
        self.view.addSubview(pickView!)
        
   
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30)
        textfield?.frame = CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: 30)
        label?.frame = CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: 30)
        switchControl?.frame = CGRect(x: 0, y: 90, width: self.view.frame.size.width, height: 30)
        segment?.frame = CGRect(x: 0, y: 120, width: self.view.frame.size.width, height: 30)
        pickView?.frame = CGRect(x: 0, y: 120, width: self.view.frame.size.width, height: 120)
    }
    
    
    func respondsToButtonAction(sender:UIButton) {
        print("tap button")
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
         print("textFieldDidBeginEditing")
    }
}


