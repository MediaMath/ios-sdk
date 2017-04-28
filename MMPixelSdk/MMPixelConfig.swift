//
//  MMPixelConfig.swift
//  MMPixelSdk
//
//  Copyright © 2017 MediaMath. All rights reserved.
//

import Foundation

class MMPixelConfig {
    static let MM_MATHTAG_URL:String = "https://pixel.mathtag.com/event/mob?mt_adid=%d&mt_id=%d&mt_time=%lu&mt_idt=idfa"
    static let MM_MAX_NUMBER_RETRIES:Int = 5
    static let MM_CONNECTION_TIMEOUT:Int = 5
    static let MM_CONNECTION_RETY_DELAY:Int = 5
    static let MM_CONNECTION_MAX_FAILED_RETRIES:Int = 2
    static let MM_DEBUG:Bool = false
    static let MM_FRAMEWORK_NAME = "MMPixelSdk"
    static let MM_FRAMEWORK_VERSION = "1.0"
}

class UserAgent {
    static func getUserAgent() -> String {
        let bundleDict = Bundle.main.infoDictionary!
        let appName = bundleDict["CFBundleName"] as! String
        let appVersion = bundleDict["CFBundleShortVersionString"] as! String
        let appDescriptor = appName + "/" + appVersion
        
        let currentDevice = UIDevice.current
        let osDescriptor = "iOS/" + currentDevice.systemVersion
        
        let hardwareString = self.getHardwareString()
        
        return appDescriptor + " (" + MMPixelConfig.MM_FRAMEWORK_NAME + " " + MMPixelConfig.MM_FRAMEWORK_VERSION
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
