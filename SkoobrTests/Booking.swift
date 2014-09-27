import Foundation
import Skoobr
import XCTest

class BookingModelTests: XCTestCase {
    
    func testBookingModelInitializer() {
        let data: [String : AnyObject] = ["id": 123, "check_in": "2014-02-01", "check_out": "2014-02-15", "property_id": 456]
        var sut: Booking
        
        let result = Booking(json: data)
        
        XCTAssertEqual((data["id"]! as? Int)!, result.id, "check id")
        XCTAssertEqual((data["check_in"]! as? String)!, result.check_in, "check check_in")
        XCTAssertEqual((data["check_out"]! as? String)!, result.check_out, "check check_out")
        XCTAssertEqual((data["property_id"]! as? Int)!, result.property_id, "check property id")
    }
    
}