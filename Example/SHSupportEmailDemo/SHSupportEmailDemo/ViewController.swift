//
//  ViewController.swift
//  SHSupportEmailDemo
//
//  Created by Stephen Hayes on 12/18/16.
//  Copyright © 2016 Stephen Hayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var supportEmail: SHSupportEmail?
    
    @IBAction func sendSupportEmailPressed() {
        supportEmail = SHSupportEmail()
        supportEmail?.customFields = ["Pro Upgrade": "Yes"]
        supportEmail?.send(to: ["support@test.com"], subject: "Support", from: self) { result, error in
            self.dismiss(animated: true, completion: nil)
            
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
