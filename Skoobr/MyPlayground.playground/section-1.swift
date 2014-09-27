import Foundation

public class Booking : NSObject {
    public let id: Int!
    public let check_in: String!
    public let check_out: String!
    public let property_id: Int!
    
    public init(json: [String : AnyObject]) {
        
        if let id = json["id"] as AnyObject? as? Int {
            self.id = id
        }
        
        if let check_in = json["check_in"] as AnyObject? as? String {
            self.check_in = check_in
        }
        
        if let check_out = json["check_out"] as AnyObject? as? String {
            self.check_out = check_out
        }
        
        if let property_id = json["property_id"] as AnyObject? as? Int {
            self.property_id = property_id
        }
        
        super.init()
        
    }
    
}


let booking1 = Booking(json: ["id": 1, "check_in": "2014-04-01", "check_out": "2014-04-15", "property_id": 11])
let booking2 = Booking(json: ["id": 2, "check_in": "2014-04-01", "check_out": "2014-04-15", "property_id": 12])
let booking3 = Booking(json: ["id": 3, "check_in": "2014-04-01", "check_out": "2014-04-15", "property_id": 11])
let booking4 = Booking(json: ["id": 4, "check_in": "2014-04-01", "check_out": "2014-04-15", "property_id": 13])

let fakeBookings = [booking1, booking2, booking3, booking4]
// 1. first we 
// we need to fetch properties too


