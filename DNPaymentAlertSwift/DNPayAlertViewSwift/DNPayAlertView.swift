//
//  DNPayAlertView.swift
//  DNPayAlertViewSwift
//
//  Created by dawnnnnn on 16/3/10.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


typealias funcBlock = (String) -> Void

class DNPayAlertView: UIView, UITextFieldDelegate {

    let titleHeight : CGFloat = 46.0
    let paymentWidth : CGFloat = UIScreen.main.bounds.size.width - 80.0
    let pwdCount = 6
    let dotWidth : CGFloat = 10.0
    let keyboardHeight : CGFloat = 216.0
    let keyViewDistance : CGFloat = 100.0
    let alertHeight : CGFloat = 200.0
    
    var completeBlock : (((String) -> Void)?)
    

    fileprivate var paymentAlert, inputWhiteView : UIView!
    fileprivate var closeBtn : UIButton!
    fileprivate var titleLabel, detailLabel, amountLabel : UILabel!
    fileprivate var pwdTextField : UITextField!
    
    fileprivate var pwdIndicatorArr = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        _initSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initSubviews() {
        if (paymentAlert == nil) {
            paymentAlert = UIView(frame: CGRect(x: 40, y: UIScreen.main.bounds.size.height - keyViewDistance - keyboardHeight - alertHeight, width: paymentWidth, height: alertHeight))
            paymentAlert.layer.cornerRadius = 5.0
            paymentAlert.layer.masksToBounds = true
            paymentAlert.backgroundColor = UIColor(white: 1, alpha: 0.95)
            self.addSubview(paymentAlert)
            
            titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: paymentWidth, height: titleHeight))
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.textColor = UIColor.darkGray
            titleLabel.font = UIFont.systemFont(ofSize: 17)
            titleLabel.text = "title"
            paymentAlert.addSubview(titleLabel)
            
            closeBtn = UIButton(type: UIButtonType.custom)
            closeBtn?.frame = CGRect(x: 0, y: 0, width: titleHeight, height: titleHeight)
            closeBtn?.setTitle("╳", for: UIControlState())
            closeBtn?.setTitleColor(UIColor.darkGray, for: UIControlState())
            closeBtn?.addTarget(self, action: #selector(DNPayAlertView.dismiss), for: UIControlEvents.touchUpInside)
            closeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            paymentAlert.addSubview(closeBtn)
            
            let line = UILabel(frame: CGRect(x: 0, y: titleHeight, width: paymentWidth, height: 0.5))
            line.backgroundColor = UIColor.lightGray
            paymentAlert.addSubview(line)
            
            detailLabel = UILabel(frame: CGRect(x: 15, y: titleHeight + 15, width: paymentWidth - 30, height: 20))
            detailLabel.textAlignment = NSTextAlignment.center
            detailLabel.textColor = UIColor.darkGray
            detailLabel.font = UIFont.systemFont(ofSize: 16)
            detailLabel.text = "detail"
            paymentAlert.addSubview(detailLabel)
            
            amountLabel = UILabel(frame: CGRect(x: 15, y: titleHeight * 2, width: paymentWidth - 30, height: 25))
            amountLabel.textAlignment = NSTextAlignment.center
            amountLabel.textColor = UIColor.darkGray
            amountLabel.font = UIFont.systemFont(ofSize: 33)
            amountLabel.text = "233"
            paymentAlert.addSubview(amountLabel)
            
            inputWhiteView = UIView(frame: CGRect(x: 15, y: paymentAlert.frame.size.height - (paymentWidth - 30) / 6 - 15, width: paymentWidth - 30, height: (paymentWidth - 30) / 6))
            inputWhiteView.backgroundColor = UIColor.white
            inputWhiteView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
            inputWhiteView.layer.borderWidth = 1.0
            paymentAlert.addSubview(inputWhiteView)
            
            pwdTextField = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            pwdTextField.isHidden = true
            pwdTextField.delegate = self
            pwdTextField.keyboardType = UIKeyboardType.numberPad
            pwdTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
            inputWhiteView.addSubview(pwdTextField)
            
            
            let width : CGFloat = inputWhiteView.bounds.size.width / CGFloat(pwdCount)
            for i in 0 ..< pwdCount {
                let dot = UILabel(frame: CGRect(x: (width - dotWidth) / 2.0 + CGFloat(i) * width, y: (inputWhiteView.bounds.size.height - dotWidth) / 2.0, width: dotWidth, height: dotWidth))
                dot.backgroundColor = UIColor.black
                dot.layer.cornerRadius = dotWidth / 2.0
                dot.clipsToBounds = true
                dot.isHidden = true
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
        let keyWindow : UIWindow = UIApplication.shared.keyWindow!
        keyWindow.addSubview(self)
        
        paymentAlert?.transform = CGAffineTransform(scaleX: 1.21, y: 1.21)
        paymentAlert?.alpha = 0
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: ({
            self.pwdTextField.becomeFirstResponder()
            self.paymentAlert?.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.paymentAlert?.alpha = 1
        }), completion: nil)
        
    }
    
    func dismiss() {
        pwdTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.5, animations: ({
            self.paymentAlert.transform = CGAffineTransform(scaleX: 1.21, y: 1.21)
            self.paymentAlert.alpha = 0
            self.alpha = 0
        }), completion: { (finishd: Bool) -> Void in
            self.removeFromSuperview()
        }) 
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.characters.count >= pwdCount) && (string.characters.count > 0)) {
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@","^[0-9]*$")
        if !predicate.evaluate(with: string) {
            return false
        }
        
        var totalString : String
        if string.characters.count <= 0 {
            let index = textField.text?.characters.index((textField.text?.endIndex)!, offsetBy: -1)
            totalString = textField.text!.substring(to: index!)
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
    
    func textFieldDidChange(_ textField: UITextField) {
        // TODO:
        /*原本想用此方法调用，奈何结束时调用了两次，不知为何..待解决*/
//        print("total______" + textField.text!)
//        self.setDotWithCount((textField.text?.characters.count)!)
//        if (textField.text?.characters.count)! == pwdCount {
//            completeBlock?(textField.text!)
//            self.dismiss()
//        }
    }
    
    func setDotWithCount(_ count : NSInteger) {
        for dot in pwdIndicatorArr {
            dot.isHidden = true
        }
        
        for i in 0 ..< count {
            pwdIndicatorArr[i].isHidden = false
        }
    }
    
    func setTitle(_ title : String) {
        titleLabel.text = title
    }
    
    func setDetail(_ detail : String) {
        detailLabel.text = detail
    }
    
    func setAmount(_ amount : CGFloat) {
        amountLabel.text = "\(amount)"
    }
    
    
}
