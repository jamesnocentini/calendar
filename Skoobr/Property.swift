import Foundation

public class Property: NSObject {
    public let id: Int!
    public let name: String!
    
    init(json: [String : AnyObject]) {
        
        if let id = json["id"] as AnyObject? as? Int {
            self.id = id
        }
        
        if let name = json["name"] as AnyObject? as? String {
            self.name = name
        }
        
        super.init()
        
    }
}