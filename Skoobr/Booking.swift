import Foundation

public class Booking : NSObject {
    public let id: Int!
    public let check_in: NSDate!
    public let check_out: NSDate!
    public let property_id: Int!
    public let nights: Int!
    public let channel: String?
    
    public init(json: [String : AnyObject]) {
        
        if let id = json["id"] as AnyObject? as? Int {
            self.id = id
        }
        
        if let check_in = json["check_in"] as AnyObject? as? String {
            self.check_in = SkoobrDatesFormatter.dateFromString(check_in)
        }
        
        if let check_out = json["check_out"] as AnyObject? as? String {
            self.check_out = SkoobrDatesFormatter.dateFromString(check_out)
        }
        
        if let property_id = json["property_id"] as AnyObject? as? Int {
            self.property_id = property_id
        }
        
        if let nights = json["nights"] as AnyObject? as? Int {
            self.nights = nights
        }
        
        if let channelObj = json["channel"] as AnyObject? as? [String : AnyObject] {
            if let channel = channelObj["name"] as AnyObject? as? String {
                self.channel = channel
            }
        }
        
        super.init()

    }
    
}
