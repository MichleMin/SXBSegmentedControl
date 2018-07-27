//
//  ViewController.swift
//  SXBSegmentedControlDemo
//
//  Created by dev_min on 2018/7/25.
//  Copyright © 2018年 dev_min. All rights reserved.
//

import UIKit
import SXBSegmentedControl

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: SXBSegmentedControl!
    @IBOutlet weak var containerView2: SXBSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "样式列表"
        containerView.viewArray = setupView()
        containerView.isHidden = false
        containerView2.vcArr = setupVC()
        containerView2.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func change(_ sender: UIBarButtonItem) {
        containerView.isHidden = !containerView.isHidden
        containerView2.isHidden = !containerView2.isHidden
    }
    

}

public extension Int {
    public static func random(lower: Int = 0, _ upper: Int = Int.max) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}


public extension UIViewController {
    
    func setupView() -> [SXBSegmentedControlModel]{
        let titles = ["测试","测试","测试","测试","测试","测试"]
        var modelArr = [SXBSegmentedControlModel]()
        for title in titles {
            let view = UIView()
            view.backgroundColor = UIColor(red: CGFloat(Int.random(lower: 1, 50))/255.0, green: CGFloat(Int.random(lower: 50, 100))/255.0, blue: CGFloat(Int.random(lower: 100, 250))/255.0, alpha: 1)
            let model = SXBSegmentedControlModel(title: title, view: view)
            modelArr.append(model)
        }
        return modelArr
    }
    
    func setupVC() -> [UIViewController]{
        let titles = ["VC测试","VC测试","VC测试","VC测试","VC测试","VC测试"]
        var vcArr = [UIViewController]()
        for i in 0..<titles.count {
            if i == 1 {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DemoViewController")
                vcArr.append(vc)
            } else {
                let vc = UIViewController()
                vc.title = titles[i]
                vc.view.backgroundColor = UIColor(red: CGFloat(Int.random(lower: 1, 50))/255.0, green: CGFloat(Int.random(lower: 50, 100))/255.0, blue: CGFloat(Int.random(lower: 100, 250))/255.0, alpha: 1)
                vcArr.append(vc)
            }
        }
        return vcArr
    }
    
}
