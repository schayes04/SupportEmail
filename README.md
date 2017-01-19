# SHSupportEmail
Prepopulates emails with support information in iOS apps

### About
SHSupportEmail is about simplifying support for apps. By prepopulating device information in your support email link, you can save your users and yourself time and needless back and forth.

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

### License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).