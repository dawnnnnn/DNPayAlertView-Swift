//
//  ViewController.swift
//  DCPaymentAlertSwift
//
//  Created by dawnnnnn on 16/3/10.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        // UIButton
        let button = UIButton(type: UIButtonType.System)
        button.frame = CGRectMake(10, 300, 200, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("buttonTitle", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(18)
        button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonClicked(sender: UIButton) {
        NSLog("hello, button")
        
        let payAlert = DCPayAlertView(frame: CGRectZero)
        payAlert.show()
    }
}

