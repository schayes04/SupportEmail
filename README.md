# SupportEmail
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat) [![CocoaPods](https://img.shields.io/cocoapods/v/SupportEmail.svg?style=flat)](https://cocoapods.org/pods/SupportEmail) [![Swift Version](https://img.shields.io/badge/Swift-5.0+-F16D39.svg?style=flat)](https://developer.apple.com/swift)

Prepopulates emails with support information in iOS apps

<p float="left">
    <img src="https://github.com/schayes04/SupportEmail/blob/main/ScreenshotAsText.png" width="300" />
    <img src="https://github.com/schayes04/SupportEmail/blob/main/ScreenshotAsFile.png" width="300" />
</p>

### About
SupportEmail is about simplifying support for apps. By prepopulating device information in your embedded support email link, you can save time and needless back and forth between you and your users. Check out [Countdowns](https://countdowns-app.com) or [Recurrence](https://recurrence-app.com) to see SupportEmail in action.

### Requirements
- Xcode 10.2+
- iOS 10.0+
- Swift 5.0+

### Installation

#### Swift Package Manager

The preferred installation method is with [Swift Package Manager](https://github.com/apple/swift-package-manager). Starting with Xcode 11, you can add packages directly from the IDE.

#### CocoaPods

You can also install with [CocoaPods](https://cocoapods.org). To do so, add the following to your Podfile:
```ruby
pod 'SupportEmail', '~> 4.0'
```

#### Carthage

You can also install with [Carthage](https://github.com/Carthage/Carthage). To do so, add the following to your Cartfile:
```
github "schayes04/SupportEmail"
```

### Usage
Due to how MFMailComposeViewController works, you must retain a reference to SupportEmail outside of where you are sending the email.
```swift
var supportEmail: SupportEmail?
```

Using SupportEmail is simple and has just one method. `send` will allow you to craft the email and handle the end result:
```swift
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
```

The send function takes 3 arguments:
- An array of email address the support email should be sent to
- The subject of the support email
- The view controller the MFMailComposeViewController is to be presented on

### Advanced
SupportEmail also supports providing custom arguments.
```swift
supportEmail.customFields = ["Pro Upgrade": "Yes"]
```

### Customization
SupportEmail allows you to provide choose between sending a text file or just content in the email body. Defaults to sending as a text file. If you are sending as a text file you can also specify the file name.
```swift
supportEmail.sendAsTextFile = true
supportEmail.fileName = "Sample File Name"
```

SupportEmail allows you to provide a tintColor in order to customize the appearance of the navigation bar.
```swift
supportEmail.tintColor = .blue
```

SupportEmail allows you to provide a baseLocale in order to localize the system locale in the email. Defaults to en-US.
```swift
supportEmail.baseLocale = Locale(identifier: "es-US")
```

SupportEmail allows you to provide a bodyPrefix that adds a default body to the email
```swift
supportEmail.bodyPrefix = "Please add any relevant feedback:\n"
```

SupportEmail allows you to change the modalPresentationStyle. Defaults to .fullScreen.
```swift
supportEmail.modalPresentationStyle = .formSheet
```

### License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
