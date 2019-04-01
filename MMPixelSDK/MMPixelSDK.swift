//
//  MMPixelSDK.swift
//  MMPixelSDK

//  Copyright © 2017 MediaMath. All rights reserved.
//

import Foundation
import AdSupport

// We declare this here because there isn't any support yet for class var / class let
let globalSdk = MMPixel();


public class MMPixel {
    
    private var isDebug = false
    private static let userAgentStr = UserAgent.getUserAgent()
    
    
    public static func setDebugOutput(debug: Bool) {
        globalSdk.isDebug = debug
    }
    
    
    public static func getDebugOutput() -> Bool {
        return globalSdk.isDebug
    }
    
    
    public static func report(advertiser: String, pixel: String, addlParams: String? = nil) {
        let adv = Int(advertiser)!
        let pix = Int(pixel)!
        report(advertiser: adv, pixel: pix, addlParams: addlParams)
    }
    
    public static func report(advertiser: String, pixel: String, addlParams: [String: String]) {
        let adv = Int(advertiser)!
        let pix = Int(pixel)!
        let addlParamsString = getAddlParamsString(addlParams: addlParams)
        report(advertiser: adv, pixel: pix, addlParams: addlParamsString)
    }


    public static func report(advertiser: Int, pixel: Int, addlParams: [String: String]) {
        let addlParamsString = getAddlParamsString(addlParams: addlParams)
        report(advertiser: advertiser, pixel: pixel, addlParams: addlParamsString)
    }
    
    
    public static func report(advertiser: Int, pixel: Int, addlParams: String? = nil) {
        let urlString = globalSdk.getPixelUrl(advertiser: advertiser, pixel: pixel, addlParams: addlParams)
        let pixelUrl = URL(string: urlString)
        
        if (globalSdk.isDebug) {
            print("MMPixelSDK firing " + urlString)
        }
        
        let config = URLSessionConfiguration.default
        let headers: [String: String] = ["User-Agent": userAgentStr]
        config.httpAdditionalHeaders = headers
        let session = URLSession(configuration: config)

        
        let task = session.dataTask(with: pixelUrl!) {(data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let usableData = data {
                    print(usableData)
                }
            }
        }
        
        task.resume()
    }
    
    
    func getPixelUrl(advertiser: Int, pixel: Int, addlParams: String?) -> String {
        let timeNow = UInt64(NSDate().timeIntervalSince1970)
        let mmFormat = MMPixelConfig.MathTagURL
        
        var urlString = String(format: mmFormat, arguments: [advertiser, pixel, timeNow])
        
        urlString += getTrackingParams(optedOut: isUserOptedOut());
        if !(addlParams ?? "").isEmpty {
            urlString += "&" + addlParams!
        }
        
        return urlString
    }
    
    
    func isUserOptedOut() -> Bool {
        return !ASIdentifierManager.shared().isAdvertisingTrackingEnabled
    }
    
    
    func getTrackingParams(optedOut: Bool) -> String {
        let idfa: String
        if optedOut {
            // use a random UUID
            idfa = NSUUID().uuidString + "&optout=1"
        }
        else {
            // use the IDFA
            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        }

        return "?mt_uuid=" + idfa   
    }

    static func getAddlParamsString(addlParams: [String: String]? = nil) -> String{
        var addlParamsString = ""
        var addlParamsArray: [String] = []
        if ((addlParams) != nil) {
            for (parameter, value) in addlParams! {
                if(parameter == "mt_excl" || (parameter == "mt_exem" && value.contains("@")) ) {
                    addlParamsArray.append(parameter + "=" + value.sha256())
                }
                else {
                    addlParamsArray.append(parameter + "=" + value)
                }
            }
        }
        addlParamsString = addlParamsArray.joined(separator: "&")
        return addlParamsString
    }

}
