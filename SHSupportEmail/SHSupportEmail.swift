//
//  SHSupportEmail.swift
//  SHSupportEmailDemo
//
//  Created by Stephen Hayes on 12/18/16.
//  Copyright © 2016 Stephen Hayes. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

public class SHSupportEmail: NSObject {
    
    var mailCompletionHandler: ((MFMailComposeResult, Error?) -> Void)?
    
    public func send(to recipients: [String], subject: String, from viewController: UIViewController, completion: ((MFMailComposeResult, Error?) -> Void)? = nil) {
        mailCompletionHandler = completion
        
        guard MFMailComposeViewController.canSendMail() else {
            mailCompletionHandler?(.failed, nil)
            return
        }
        
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        
        mailComposeViewController.setToRecipients(recipients)
        mailComposeViewController.setSubject(subject)
        mailComposeViewController.setMessageBody(generateEmailBody(), isHTML: false)
        
        viewController.present(mailComposeViewController, animated: true, completion: nil)
    }
    
    /// Generate the body of the email
    private func generateEmailBody() -> String {
        
        /// Initial new lines leave space for the user to write their own text
        var deviceInfo = "\n\n\n\n\n------------------\n"
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] {
            deviceInfo.append("App Version: \(version)\n")
        }
        
        deviceInfo.append("Device Model: \(UIDevice.current.model)\n")
        deviceInfo.append("System Version: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)\n")
        deviceInfo.append("System Locale: \(Locale.current.identifier)")
        
        return deviceInfo
    }
}

extension SHSupportEmail: MFMailComposeViewControllerDelegate {

    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        mailCompletionHandler?(result, error)
    }
}
