# DCPayAlertView-Swift
A payment alertview that imitating Wechat with six digital pay passwords.<br/>

一款模仿微信的6位数字支付密码弹框——Swift版
<br/>

```
自己在练Swift的时候改写了一下.. 有问题多指教
```

### [同款OC版点击此处](https://github.com/dawnnnnn/DCPayAlertView)

<br/>
# Preview 预览
![screenshots](https://raw.githubusercontent.com/dawnnnnn/DCPayAlertView/master/screenshots/DCPaymentDemo.gif)


# Usage 使用
``` swift
        let payAlert = DCPayAlertView(frame: CGRectZero)
        payAlert.setTitle("请输入支付密码")
        payAlert.setDetail("提现")
        payAlert.setAmount(10)
        payAlert.completeBlock = ({(password: String) -> Void in
            print("password" + password)
        })
        payAlert.show()
```
    
    
# License  
MIT