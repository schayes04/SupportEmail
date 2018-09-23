//
//  SupportEmail.swift
//  SupportEmail
//
//  Created by Stephen Hayes on 12/18/16.
//  Copyright © 2018 Stephen Hayes. All rights reserved.
//

import UIKit
import MessageUI

public class SupportEmail: NSObject {

    public var customFields: [String: Any]?
    public var sendAsTextFile = true
    public var tintColor: UIColor?
    public var fileName = "Device Info"
    public var baseLocale = Locale(identifier: "en_US")

    private var mailCompletionHandler: ((MFMailComposeResult, Error?) -> Void)?

    public func send(to recipients: [String],
                     subject: String,
                     from viewController: UIViewController,
                     completion: ((MFMailComposeResult, Error?) -> Void)? = nil) {
        mailCompletionHandler = completion

        guard MFMailComposeViewController.canSendMail() else {
            mailCompletionHandler?(.failed, nil)
            return
        }

        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self

        mailComposeViewController.setToRecipients(recipients)
        mailComposeViewController.setSubject(subject)

        let deviceInfo = generateEmailBody()
        if sendAsTextFile, let data = deviceInfo.data(using: .utf8) {
            mailComposeViewController.addAttachmentData(data, mimeType: "text/plain", fileName: fileName)
        } else {
            /// Add new lines to leave space for the user to write their own text
            let deviceInfoNewLines = "\n\n\n\n------------------\n" + deviceInfo
            mailComposeViewController.setMessageBody(deviceInfoNewLines, isHTML: false)
        }

        if let tintColor = tintColor {
            let attributes = [NSAttributedString.Key.foregroundColor: tintColor]

            mailComposeViewController.navigationBar.tintColor = tintColor
            mailComposeViewController.navigationBar.titleTextAttributes = attributes
        }

        viewController.present(mailComposeViewController, animated: true)
    }

    /// Generate the body of the email
    private func generateEmailBody() -> String {
        var deviceInfo = ""

        if let customFields = customFields {
            for (key, value) in customFields {
                deviceInfo.append("\(key): \(value)\n")
            }
        }

        // Add spacing between the custom fields and the default ones
        deviceInfo.append("\n")

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] {
            deviceInfo.append("App Version: \(version)\n")
        }

        deviceInfo.append("Device Model: \(UIDevice.modelName)\n")
        deviceInfo.append("System Version: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)\n")
        deviceInfo.append("System Locale: \(baseLocale.localizedString(forIdentifier: Locale.current.identifier) ?? Locale.current.identifier)")

        return deviceInfo
    }
}

extension SupportEmail: MFMailComposeViewControllerDelegate {

    public func mailComposeController(_ controller: MFMailComposeViewController,
                                      didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        mailCompletionHandler?(result, error)
    }
}
