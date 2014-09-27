//
//  SkoobrAPITests.swift
//  SkoobrAPITests
//
//  Created by James Nocentini on 05/09/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import Foundation
import NetworkManager
import XCTest

class SkoobrAPITests: XCTestCase {
    
    override func setUp() {
        if Manager.shared.isAuthorized {
            
        } else {
            ManagerPOSTRequestBodyIsValid()
        }
        
    }
    
    // Helper method for login
    func ManagerPOSTRequestBodyIsValid() {
        let data = ["email": "james@keepmebooked.com", "password": "12345678"]
        let credentials = (URL: "http://www.skoobr.com/api/users/sign_in", data: data)
        
        
        let expectation = expectationWithDescription("\(credentials.URL)")
        Manager.shared.authorizeWithCredentials(credentials, responseHandler: { (status) -> () in
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            XCTAssertNil(error, "\(error)")
        })
        
    }
    
    func testSingletonSharedInstanceCreated() {
        XCTAssertNotNil(Manager.shared, "manager instance is not nil")
    }
    
    func testManagerWithDefaultSessionConfig() {
        XCTAssertNotNil(Manager.shared.session, "manager session is not nil")
    }
    
    func testManagerWithRequestInstanceMethod() {
        let URL = "http://www.skoobr.com/api/users"
        
        let expectation = expectationWithDescription("\(URL)")
        Manager.shared.request(.GET, URL: URL) { (json, response, error) -> () in
            expectation.fulfill()
            
            XCTAssertNotNil(json, "data not nil")
            XCTAssertNotNil(response, "response not nil")
            XCTAssertNil(error, "error is nil")
        }
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "\(error)")
        })
        
    }
    
    func testManagerSerializingJSONIsValid() {
        let dictionary = ["email": "james@keepmebooked.com", "password": "12345678"]
        
        let data: NSData = Manager.shared.serializeJSON(dictionary)
        
        XCTAssertNotNil(data, "serialized json non nil")
    }
    
    func testManagerDeserializingJSONIsValid() {
        let string = "{\"email\": \"james@keepmebooked.com\", \"password\": \"12345678\"}"
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        
        let object: AnyObject = Manager.shared.deserializeJSON(data)
        
        XCTAssertNotNil(object, "not nil")
    }
    
    func testManagerGETRequestUserDetailsIsValid() {
        let URL = "http://www.skoobr.com/api/users"
        
        let expectation = expectationWithDescription("\(URL) 2")
        Manager.shared.request(.GET, URL: URL) { (json, response, error) -> () in
            expectation.fulfill()
            
            if let jsonUnwrapped = json as? [String : AnyObject] {
                if let full_name = jsonUnwrapped["full_name"] as AnyObject? as? String {
                    XCTAssertEqual(full_name, "James Nocentini", "name should be correct")
                }
            }
        }
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            XCTAssertNil(error, "\(error)")
        })
    }
    
    func testManagerWithHttpBinPOSTisValid() {
        let URL = "http://httpbin.org/post"
        let data = ["name": "James Stuart"]
        
        let expectation = expectationWithDescription("\(URL)")
        Manager.shared.upload(.POST, URL: URL, data: data) { (json, response, error) -> () in
            expectation.fulfill()
            
            XCTAssertEqual(json!["json"] as NSObject, ["name": "James Stuart"], "args should be equal")
        }
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            XCTAssertNil(error, "\(error)")
        })
    }
    
}