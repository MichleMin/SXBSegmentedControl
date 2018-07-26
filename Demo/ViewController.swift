//
//  ViewController.swift
//  SXBSegmentedControlDemo
//
//  Created by dev_min on 2018/7/25.
//  Copyright © 2018年 dev_min. All rights reserved.
//

import UIKit
//import SXBSegmentedControl

class ViewController: UIViewController {

//    var sxba:SXB
    
    var topScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func set(attributes:[NSAttributedStringKey: Any], state: UIControlState) {
            for btn in topScrollView.subviews {
                if let btn = btn as? UIButton, let title = btn.title(for: state) {
                    let titleAttributed = NSAttributedString(string: title, attributes: attributes)
                    btn.setAttributedTitle(titleAttributed, for: state)
                }
            }
        }


}

