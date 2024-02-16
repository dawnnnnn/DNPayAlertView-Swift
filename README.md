# DCPayAlertView-Swift
A payment alertview that imitating Wechat with six digital pay passwords.<br/>

一款模仿微信的6位数字支付密码弹框——Swift版


### [同款OC版点击此处](https://github.com/dawnnnnn/DNPayAlertView)


## Preview 预览

![screenshots](https://raw.githubusercontent.com/dawnnnnn/DCPayAlertView/master/screenshots/DCPaymentDemo.gif)


## Usage 使用
support：iOS 9.2 and later

``` swift
	let payAlert = DNPayAlertView.show()
	payAlert.setTitle("请输入支付密码")
	payAlert.setDetail("提现")
	payAlert.setAmount(10)
	payAlert.completeBlock = ({(password: String) -> Void in
		print("password" + password)
	})
```
    
## Update 更新
2017/01/25 : 更名为DNPayAlertViewSwift
    
## License  
MIT

## Contact
tan32211@gmail.com