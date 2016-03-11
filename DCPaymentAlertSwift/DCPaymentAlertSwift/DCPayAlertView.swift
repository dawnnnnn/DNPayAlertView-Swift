//
//  DCPayAlertView.swift
//  DCPaymentAlertSwift
//
//  Created by dawnnnnn on 16/3/10.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

import UIKit

typealias funcBlock = (String) -> Void

class DCPayAlertView: UIView, UITextFieldDelegate {

    let titleHeight : CGFloat = 46.0
    let paymentWidth : CGFloat = UIScreen.mainScreen().bounds.size.width - 80.0
    let pwdCount = 6
    let dotWidth : CGFloat = 10.0
    let keyboardHeight : CGFloat = 216.0
    let keyViewDistance : CGFloat = 100.0
    let alertHeight : CGFloat = 200.0
    
    var completeBlock : (((String) -> Void)?)
    

    private var paymentAlert, inputWhiteView : UIView!
    private var closeBtn : UIButton!
    private var titleLabel, detailLabel, amountLabel : UILabel!
    private var pwdTextField : UITextField!
    
    private var pwdIndicatorArr = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        _initSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initSubviews() {
        if (paymentAlert == nil) {
            paymentAlert = UIView(frame: CGRect(x: 40, y: UIScreen.mainScreen().bounds.size.height - keyViewDistance - keyboardHeight - alertHeight, width: paymentWidth, height: alertHeight))
            paymentAlert.layer.cornerRadius = 5.0
            paymentAlert.layer.masksToBounds = true
            paymentAlert.backgroundColor = UIColor(white: 1, alpha: 0.95)
            self.addSubview(paymentAlert)
            
            titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: paymentWidth, height: titleHeight))
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.textColor = UIColor.darkGrayColor()
            titleLabel.font = UIFont.systemFontOfSize(17)
            titleLabel.text = "title"
            paymentAlert.addSubview(titleLabel)
            
            closeBtn = UIButton(type: UIButtonType.Custom)
            closeBtn?.frame = CGRectMake(0, 0, titleHeight, titleHeight)
            closeBtn?.setTitle("╳", forState: UIControlState.Normal)
            closeBtn?.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
            closeBtn?.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
            closeBtn?.titleLabel?.font = UIFont.systemFontOfSize(15)
            paymentAlert.addSubview(closeBtn)
            
            let line = UILabel(frame: CGRect(x: 0, y: titleHeight, width: paymentWidth, height: 0.5))
            line.backgroundColor = UIColor.lightGrayColor()
            paymentAlert.addSubview(line)
            
            detailLabel = UILabel(frame: CGRect(x: 15, y: titleHeight + 15, width: paymentWidth - 30, height: 20))
            detailLabel.textAlignment = NSTextAlignment.Center
            detailLabel.textColor = UIColor.darkGrayColor()
            detailLabel.font = UIFont.systemFontOfSize(16)
            detailLabel.text = "detail"
            paymentAlert.addSubview(detailLabel)
            
            amountLabel = UILabel(frame: CGRect(x: 15, y: titleHeight * 2, width: paymentWidth - 30, height: 25))
            amountLabel.textAlignment = NSTextAlignment.Center
            amountLabel.textColor = UIColor.darkGrayColor()
            amountLabel.font = UIFont.systemFontOfSize(33)
            amountLabel.text = "233"
            paymentAlert.addSubview(amountLabel)
            
            inputWhiteView = UIView(frame: CGRect(x: 15, y: paymentAlert.frame.size.height - (paymentWidth - 30) / 6 - 15, width: paymentWidth - 30, height: (paymentWidth - 30) / 6))
            inputWhiteView.backgroundColor = UIColor.whiteColor()
            inputWhiteView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).CGColor
            inputWhiteView.layer.borderWidth = 1.0
            paymentAlert.addSubview(inputWhiteView)
            
            pwdTextField = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            pwdTextField.hidden = true
            pwdTextField.delegate = self
            pwdTextField.keyboardType = UIKeyboardType.NumberPad
            inputWhiteView.addSubview(pwdTextField)
            
            
            let width : CGFloat = inputWhiteView.bounds.size.width / CGFloat(pwdCount)
            for var i = 0; i < pwdCount; i++ {
                let dot = UILabel(frame: CGRect(x: (width - dotWidth) / 2.0 + CGFloat(i) * width, y: (inputWhiteView.bounds.size.height - dotWidth) / 2.0, width: dotWidth, height: dotWidth))
                dot.backgroundColor = UIColor.blackColor()
                dot.layer.cornerRadius = dotWidth / 2.0
                dot.clipsToBounds = true
                dot.hidden = true
                inputWhiteView.addSubview(dot)
                pwdIndicatorArr.append(dot)
                
                if i == pwdCount - 1 {
                    continue
                }
                let line = UILabel(frame: CGRect(x: CGFloat(i+1) * width, y: 0, width: 0.5, height: inputWhiteView.bounds.size.height))
                line.backgroundColor = UIColor(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1)
                inputWhiteView.addSubview(line)
            }
            
        }
    }

    func show() {
        let keyWindow : UIWindow = UIApplication.sharedApplication().keyWindow!
        keyWindow.addSubview(self)
        
        paymentAlert?.transform = CGAffineTransformMakeScale(1.21, 1.21)
        paymentAlert?.alpha = 0
        
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            self.pwdTextField.becomeFirstResponder()
            self.paymentAlert?.transform = CGAffineTransformMakeScale(1, 1)
            self.paymentAlert?.alpha = 1
        }), completion: nil)
        
    }
    
    func dismiss() {
        pwdTextField.resignFirstResponder()
        
        UIView.animateWithDuration(0.35, animations: ({
            self.paymentAlert.transform = CGAffineTransformMakeScale(1.21, 1.21)
            self.paymentAlert.alpha = 0
            self.alpha = 0
        })) { (finishd: Bool) -> Void in
            self.removeFromSuperview()
        }
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.characters.count >= pwdCount) && (string.characters.count > 0)) {
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@","^[0-9]*$")
        if !predicate.evaluateWithObject(string) {
            return false
        }
        
        var totalString : String
        if string.characters.count <= 0 {
            let index = textField.text?.endIndex.advancedBy(-1)
            totalString = textField.text!.substringToIndex(index!)
        }
        else {
            totalString = textField.text! + string
        }
        
        self.setDotWithCount(totalString.characters.count)
        print("total______" + totalString)
        
        if totalString.characters.count == 6 {
            print("complete")
            completeBlock?(totalString)
            self.dismiss()
        }
        
        return true
    }
    
    func setDotWithCount(count : NSInteger) {
        for dot in pwdIndicatorArr {
            dot.hidden = true
        }
        
        for var i = 0; i < count; i++ {
            pwdIndicatorArr[i].hidden = false
        }
    }
    
    func setTitle(title : String) {
        titleLabel.text = title
    }
    
    func setDetail(detail : String) {
        detailLabel.text = detail
    }
    
    func setAmount(amount : CGFloat) {
        amountLabel.text = "\(amount)"
    }
    
    
}
