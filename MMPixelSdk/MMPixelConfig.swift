//
//  MMPixelConfig.swift
//  MMiOSPixelSdk
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
}
