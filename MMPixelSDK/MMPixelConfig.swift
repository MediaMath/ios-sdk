//
//  MMPixelConfig.swift
//  MMPixelSDK
//
//  Copyright © 2017 MediaMath. All rights reserved.
//

import Foundation

struct MMPixelConfig {
    static let MathTagURL: String = "https://pixel.mathtag.com/event/mob?mt_adid=%d&mt_id=%d&mt_time=%lu&mt_idt=idfa"
    static let FrameworkName = "MMPixelSDK"
    static let FrameworkVersion = "1.0"
}

class UserAgent {
    static func getUserAgent() -> String {
        let bundleDict = Bundle.main.infoDictionary!
        let appName = bundleDict["CFBundleName"] as? String ?? MMPixelConfig.FrameworkName
        let appVersion = bundleDict["CFBundleShortVersionString"] as? String ?? MMPixelConfig.FrameworkVersion
        let appDescriptor = appName + "/" + appVersion
        
        let currentDevice = UIDevice.current
        let osDescriptor = "iOS/" + currentDevice.systemVersion
        
        let hardwareString = self.getHardwareString()
        
        return appDescriptor + " (" + MMPixelConfig.FrameworkName + " " + MMPixelConfig.FrameworkVersion
            + ") " + osDescriptor + " (" + hardwareString + ")"
    }
    
    static func getHardwareString() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, &name, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, &name, 0)
        
        let hardware: String = String.init(validatingUTF8: hw_machine)!
        return hardware
    }
}
