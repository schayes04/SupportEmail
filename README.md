# SHSupportEmail
[![Build Status](https://travis-ci.org/schayes04/SHSupportEmail.svg?branch=master)](https://travis-ci.org/schayes04/SHSupportEmail) [![Swift Version](https://img.shields.io/badge/Swift-3.0+-F16D39.svg?style=flat)](https://developer.apple.com/swift)

Prepopulates emails with support information in iOS apps

![Screenshot](/Screenshot.PNG?raw=true)

### About
SHSupportEmail is about simplifying support for apps. By prepopulating device information in your embedded support email link, you can save time and needless back and forth between you and your users.

### Requirements
- Xcode 8.0+
- iOS 8.0+
- Swift 3.0+

### Installation
Manually for now, CocoaPods and Carthage support coming soon!

### Usage
SHSupportEmail is really simple and currently has just one method.

    SHSupportEmail().send(to: ["support@test.com"], subject: "Support", from: self) { result, error in
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

### License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
