//
//  MMPixelSDKTests
//
//  Copyright © 2017 MediaMath. All rights reserved.
//

import XCTest
import AdSupport

@testable import MMPixelSDK

class MMPixelSDKTests: XCTestCase {
    
    var mm = MMPixel()
    
    override func setUp() {
        super.setUp()
        MMPixel.setDebugOutput(debug: true)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
       
    func testGetPixelUrl() {
        //https://pixel.mathtag.com/event/html?mt_adid=ADVERTISER_ID&mt_id=PIXEL_ID&mt_uuid=UUID&mt_idt=idfa&ADDITIONAL_PARAMETERS
        
        let expected = "https://pixel.mathtag.com/event/mob?mt_adid=123&mt_id=456"
        let actual = mm.getPixelUrl(advertiser: 123, pixel: 456, addlParams: nil)
        XCTAssert(actual.hasPrefix(expected), "Pixel URL should contain advertiser and pixel IDs")
        
    }
    
    func testGetPixelUrlWithAddlParams() {
        let addlParams = "foo1=lol"
        let actual = mm.getPixelUrl(advertiser: 123, pixel: 456, addlParams: addlParams)
        XCTAssert(actual.hasSuffix("&foo1=lol"), "Pixel URL should end in additionalParams string")
        
    }

    
    func testGetTrackingParams() {
        let optedOut = mm.getTrackingParams(optedOut: true)
        let tracked = mm.getTrackingParams(optedOut: false)
        
        XCTAssert(optedOut.hasSuffix("&optout=1"), "opted out string should contain &optout=1")
        XCTAssert(!tracked.hasSuffix("&optout=1"), "tracked out string should not contain &optout=1")
    }
    
    
    func testFirePixelWithIntegers() {
        MMPixel.report(advertiser: 123, pixel: 456)
    }
    
    func testFirePixelWithStrings() {
        MMPixel.report(advertiser: "789", pixel: "012")
    }
    
}
