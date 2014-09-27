//
//  DateManager.swift
//  Skoobr
//
//  Created by James Nocentini on 08/09/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import Foundation
import Skoobr
import XCTest

class TestDateManager: XCTestCase {
    
    func testTodayTypeVariable() {
        let sut = DateManager.self
        
        let result = sut.today
        
        XCTAssertNotNil(result, "today type variables is not nil")
    }
    
    func testMaximumTypeVariable() {
        let sut = DateManager.self
        let sutComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.MonthCalendarUnit, fromDate: sut.today)
        
        let result = sut.maximum
        let resultComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.MonthCalendarUnit, fromDate: result)
        
        XCTAssertNotNil(result, "maximum date should not be nil")
        XCTAssertEqual(resultComponents.month, sutComponents.month + 1, "computed max property")
    }
    
    func testMinimumTypeVariable() {
        let sut = DateManager.self
        let sutComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.MonthCalendarUnit, fromDate: sut.today)
        
        let result = sut.minimum
        let resultComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.MonthCalendarUnit, fromDate: result)
        
        XCTAssertNotNil(result, "minimum exists")
        XCTAssertEqual(resultComponents.month, sutComponents.month - 1, "computed min property")
    }
    
    
}