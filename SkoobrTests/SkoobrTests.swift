//
//  SkoobrTests.swift
//  SkoobrTests
//
//  Created by James Nocentini on 07/09/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit
import Skoobr
import ModelManager
import XCTest

class SkoobrTests: XCTestCase {
    
    func testBookingModelInitializer() {
        let sut = Booking(json: ["james": "object"])
        
        
        XCTAssertNotNil(sut, "instance not nil")
    }
    
    func testCollectionInstanceForBookingsRequestMethod() {
        let URL = "http://www.skoobr.com/api/bookings"
        var sut = Collection(URL: URL)
        
        let expectation = expectationWithDescription("\(URL)")
        sut.request { (json, response, error) -> () in
            expectation.fulfill()

            println(json)
        }
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            XCTAssertNil(error, "\(error)")
        })
    }
}
