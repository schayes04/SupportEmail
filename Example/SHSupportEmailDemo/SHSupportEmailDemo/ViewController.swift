//
//  ViewController.swift
//  SHSupportEmailDemo
//
//  Created by Stephen Hayes on 12/18/16.
//  Copyright © 2016 Stephen Hayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func sendSupportEmailPressed() {
        SHSupportEmail.sharedInstance.send(to: ["support@test.com"], subject: "Support", from: self) { (result, error) in
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
