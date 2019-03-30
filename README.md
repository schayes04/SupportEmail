# SupportEmail
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat) [![CocoaPods](https://img.shields.io/cocoapods/v/SupportEmail.svg?style=flat)](https://cocoapods.org/pods/SupportEmail) [![Swift Version](https://img.shields.io/badge/Swift-5.0+-F16D39.svg?style=flat)](https://developer.apple.com/swift)

Prepopulates emails with support information in iOS apps

<p float="left">
    <img src="/ScreenshotAsText.png" width="300" />
    <img src="/ScreenshotAsFile.png" width="300" />
</p>

### About
SupportEmail is about simplifying support for apps. By prepopulating device information in your embedded support email link, you can save time and needless back and forth between you and your users. Check out [Countdown Widget](https://itunes.apple.com/us/app/countdown-widget-keep-track/id917514700?mt=8) to see SupportEmail in action.

### Requirements
- Xcode 10.2+
- iOS 8.0+
- Swift 5.0+

### Installation
#### CocoaPods

The preferred installation method is with [CocoaPods](https://cocoapods.org). Add the following to your Podfile:
```ruby
pod 'SupportEmail', '~> 3.0'
```

### Usage
Due to how MFMailComposeViewController works, you must retain a reference to SupportEmail outside of where you are sending the email.

    var supportEmail: SupportEmail?

Using SupportEmail is simple and has just one method. `send` will allow you to craft the email and handle the end result:

    supportEmail = SupportEmail()
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
SupportEmail also supports providing custom arguments.

    supportEmail.customFields = ["Pro Upgrade": "Yes"]

### Customization
SupportEmail allows you to provide choose between sending a text file or just content in the email body. Defaults to sending as a text file. If you are sending as a text file you can also specify the file name.

    supportEmail.sendAsTextFile = true
    supportEmail.fileName = "Sample File Name"

SupportEmail allows you to provide a tintColor in order to customize the appearance of the navigation bar.

    supportEmail.tintColor = .blue
    
SupportEmail allows you to provide a baseLocale in order to localize the system locale in the email. Defaults to en-US.
    
    supportEmail.baseLocale = Locale(identifier: "es-US")

### License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
