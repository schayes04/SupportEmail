//
//  SHSupportEmail.swift
//  SHSupportEmail
//
//  Created by Stephen Hayes on 12/18/16.
//  Copyright © 2018 Stephen Hayes. All rights reserved.
//

import UIKit
import MessageUI

public class SHSupportEmail: NSObject {

    public var customFields: [String: Any]?
    public var sendAsTextFile = true
    public var tintColor: UIColor?
    public var statusBarStyle = UIStatusBarStyle.lightContent
    public var fileName = "DeviceInfo"

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
            let attributes = [NSAttributedStringKey.foregroundColor: tintColor]

            mailComposeViewController.navigationBar.tintColor = tintColor
            mailComposeViewController.navigationBar.titleTextAttributes = attributes
        }

        viewController.present(mailComposeViewController, animated: true) { [weak self] in
            if let weakSelf = self {
                UIApplication.shared.statusBarStyle = weakSelf.statusBarStyle
            }
        }
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

        deviceInfo.append("Device Type Identifier: \(deviceTypeIdentifier())\n")
        deviceInfo.append("Device Model: \(UIDevice.current.model)\n")
        deviceInfo.append("System Version: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)\n")
        deviceInfo.append("System Locale: \(Locale.current.identifier)")

        return deviceInfo
    }

    private func deviceTypeIdentifier() -> String {
        #if targetEnvironment(simulator)
            return "Simulator"
        #endif

        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)?.trimmingCharacters(in: .controlCharacters) ?? "Unknown"
    }
}

extension SHSupportEmail: MFMailComposeViewControllerDelegate {

    public func mailComposeController(_ controller: MFMailComposeViewController,
                                      didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        mailCompletionHandler?(result, error)
    }
}
