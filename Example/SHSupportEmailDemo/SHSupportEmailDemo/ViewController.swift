//
//  ViewController.swift
//  SHSupportEmailDemo
//
//  Created by Stephen Hayes on 12/18/16.
//  Copyright © 2018 Stephen Hayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var supportEmail: SHSupportEmail?

    @IBAction func sendSupportEmailPressed() {
        supportEmail = SHSupportEmail()
        supportEmail?.customFields = ["Pro Upgrade": "Yes"]
        supportEmail?.tintColor = .blue
        supportEmail?.sendAsTextFile = false
        supportEmail?.send(to: ["support@test.com"], subject: "Support", from: self) { result, _ in
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
    }
}
