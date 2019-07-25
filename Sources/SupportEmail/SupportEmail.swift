import UIKit
import MessageUI

public class SupportEmail: NSObject {

    /// Dictionary of custom fields to include in email.
    public var customFields: [String: Any]?

    /// Determines if the support information is sent as part of the body or as an attached text file. Defaults to `true`.
    public var sendAsTextFile = true

    /// Tthe tintColor of the navigation bar.
    public var tintColor: UIColor?

    /// The name of the file generated, if `sendAsTextFile` is true. Defaults to `"Device Info"`.
    public var fileName = "Device Info"

    /// The locale used to display the user's locale.
    public var baseLocale = Locale(identifier: "en_US")

    /// A prefix for the email's body. Defaults to `""`.
    public var bodyPrefix = ""

    /// The presentation style used for the modal. Defaults to `.fullScreen`.
    public var modalPresentationStyle = UIModalPresentationStyle.fullScreen

    /// Completion block called with a result and/or error.
    private var mailCompletionHandler: ((MFMailComposeResult, Error?) -> Void)?

    /// Prompt user to send an email with associated support information.
    /// - Parameter recipients: email addresses.
    /// - Parameter subject: email subject.
    /// - Parameter viewController: where the modal should be presented from.
    /// - Parameter completion: completion block called with a result and/or error.
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
        mailComposeViewController.modalPresentationStyle = modalPresentationStyle

        mailComposeViewController.setToRecipients(recipients)
        mailComposeViewController.setSubject(subject)

        let deviceInfo = generateEmailBody()
        if sendAsTextFile, let data = deviceInfo.data(using: .utf8) {
            mailComposeViewController.setMessageBody(bodyPrefix, isHTML: false)
            mailComposeViewController.addAttachmentData(data, mimeType: "text/plain", fileName: fileName)
        } else {
            /// Add new lines to leave space for the user to write their own text
            let body = bodyPrefix + "\n\n\n\n------------------\n" + deviceInfo
            mailComposeViewController.setMessageBody(body, isHTML: false)
        }

        if let tintColor = tintColor {
            mailComposeViewController.navigationBar.tintColor = tintColor
            mailComposeViewController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
        }

        viewController.present(mailComposeViewController, animated: true)
    }

    /// Generate the body of the email.
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

    /// MFMailComposeViewControllerDelegate when composer finishes.
    /// - Parameter controller: MFMailComposeViewController
    /// - Parameter result: MFMailComposeResult
    /// - Parameter error: Error
    public func mailComposeController(_ controller: MFMailComposeViewController,
                                      didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        mailCompletionHandler?(result, error)
    }
}
