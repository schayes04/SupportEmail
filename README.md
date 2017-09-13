# SHSupportEmail
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat) [![CocoaPods](https://img.shields.io/cocoapods/v/SHSupportEmail.svg?style=flat)](https://cocoapods.org/pods/SHSupportEmail) [![Swift Version](https://img.shields.io/badge/Swift-4.0+-F16D39.svg?style=flat)](https://developer.apple.com/swift)

Prepopulates emails with support information in iOS apps

<img src="/Screenshot.PNG" width="300">

### About
SHSupportEmail is about simplifying support for apps. By prepopulating device information in your embedded support email link, you can save time and needless back and forth between you and your users. Check out [Countdown Widget](https://itunes.apple.com/us/app/countdown-widget-keep-track/id917514700?mt=8) to see SHSupportEmail in action.

### Requirements
- Xcode 9.0+
- iOS 8.0+
- Swift 4.0+

### Installation
#### CocoaPods

The preferred installation method is with [CocoaPods](https://cocoapods.org). Add the following to your Podfile:
```ruby
pod 'SHSupportEmail', '~> 2.0.0'
```

### Usage
SHSupportEmail is really simple and currently has just one method.

    let supportEmail = SHSupportEmail()
    supportEmail.send(to: ["support@test.com"], subject: "Support", from: self) { result, error in
        switch result {
            case .cancelled:
                print("Message cancelled")
            case .failed:
                print("Message failed")
            case .saved:
                print("Message saved")
            case .sent:
                print("Message sent")
        }
    }

The send function takes 3 arguments:
- An array of email address the support email should be sent to
- The subject of the support email
- The view controller the MFMailComposeViewController is to be presented on

### Advanced
SHSupportEmail also supports providing custom arguments.

    let supportEmail = SHSupportEmail()
    supportEmail.customFields = ["Pro Upgrade": "Yes"]
    supportEmail.send(to: ["support@test.com"], subject: "Support", from: self) { result, error in
        switch result {
            case .cancelled:
                print("Message cancelled")
            case .failed:
                print("Message failed")
            case .saved:
                print("Message saved")
            case .sent:
                print("Message sent")
        }
    }

### Customization
SHSupportEmail allows you to provide a tintColor in order to customize the appearance of the navigation bar. It also allows you to specify the status bar style.

    let supportEmail = SHSupportEmail()
    supportEmail.tintColor = .blue
    supportEmail.statusBarStyle = .lightContent
    supportEmail.send(to: ["support@test.com"], subject: "Support", from: self) { result, error in
        switch result {
            case .cancelled:
                print("Message cancelled")
            case .failed:
                print("Message failed")
            case .saved:
                print("Message saved")
            case .sent:
                print("Message sent")
        }
    }

### License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
