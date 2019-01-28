//
//  DeviceExtensions.swift
//  SupportEmail
//
//  Created by Stephen Hayes on 5/28/18.
//  Copyright © 2018 Stephen Hayes. All rights reserved.
//

import UIKit

extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {

        // Simulators

        case "i386", "x86_64":
            return "Simulator"

        // iPods

        case "iPod1,1", "iPod2,1", "iPod3,1", "iPod4,1", "iPod5,1", "iPod7,1":
            return "iPod Touch"

        // iPhones

        case "iPhone1,1":
            return "iPhone 2G"
        case "iPhone1,2":
            return "iPhone 3G"
        case "iPhone2,1":
            return "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return "iPhone 4"
        case "iPhone4,1":
            return "iPhone 4S"
        case "iPhone5,1", "iPhone5,2":
            return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":
            return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":
            return "iPhone 5s"
        case "iPhone7,1":
            return "iPhone 6 Plus"
        case "iPhone7,2":
            return "iPhone 6"
        case "iPhone8,1":
            return "iPhone 6S"
        case "iPhone8,2":
            return "iPhone 6S Plus"
        case "iPhone8,4":
            return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":
            return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":
            return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":
            return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":
            return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":
            return "iPhone X"
        case "iPhone11,2":
            return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":
            return "iPhone XS Max"
        case "iPhone11,8":
            return "iPhone XR"

        // iPads

        case "iPad1,1":
            return "iPad (1st Generation)"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return "iPad (2nd Generation)"
        case "iPad3,1", "iPad3,2", "iPad3,3":
            return "iPad (3rd Generation)"
        case "iPad3,4", "iPad3,5", "iPad3,6":
            return "iPad (4th Generation)"
        case "iPad6,11", "iPad6,12":
            return "iPad (5th Generation)"
        case "iPad7,5", "iPad7,6":
            return "iPad (6th Generation)"

        case "iPad2,5", "iPad2,6", "iPad2,7":
            return "iPad Mini (1st Generation)"
        case "iPad4,4", "iPad4,5", "iPad4,6":
            return "iPad Mini (2nd Generation)"
        case "iPad4,7", "iPad4,8", "iPad4,9":
            return "iPad Mini (3rd Generation)"
        case "iPad5,1", "iPad5,2":
            return "iPad Mini (4th Generation)"

        case "iPad4,1", "iPad4,2":
            return "iPad Air (1st Generation)"
        case "iPad5,3", "iPad5,4":
            return "iPad Air (2nd Generation)"

        case "iPad6,3", "iPad6,4":
            return "iPad Pro 9.7inch (1st Generation)"
        case "iPad7,3", "iPad7,4":
            return "iPad Pro 10.5inch (1st Generation)"
        case "iPad6,7", "iPad6,8":
            return "iPad Pro 12.9inch (1st Generation)"
        case "iPad7,1", "iPad7,2":
            return "iPad Pro 12.9inch (2nd Generation)"

        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":
            return "iPad Pro 11inch (3rd Generation)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":
            return "iPad Pro 12.9inch (3rd Generation)"

        default:
            return "Unknown identifier: \(identifier)"
        }
    }()
}
