public enum Method: String {
    case GET = "GET"
    case POST = "POST"
    case UPDATE = "UPDATE"
    case DELETE = "DELETE"
}

let SkoobrAPIAuthorizationHeader = "Token token=\"null\", client=\"xyxXFRyPusR4TP3XLieWbPhTUeE7etZDh9q3De-5\""

public class Manager {
    public class var shared: Manager {
        
    struct Static {
        static let instance: Manager = Manager()
        }
        
        return Static.instance
    }
    
    public let session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    private var computed_auth_token: String = SkoobrAPIAuthorizationHeader
    public var auth_token: String {
        get {
            return computed_auth_token
        }
        set(newToken) {
            computed_auth_token = "Token token=\"" + newToken + "\", client=\"xyxXFRyPusR4TP3XLieWbPhTUeE7etZDh9q3De-5\""
        }
    }
    public var isAuthorized: Bool = false
    
    public func request(method: Method, URL: String, completion: (json: AnyObject!, response: NSURLResponse!, error: NSError!) -> ()) {
        let request = NSMutableURLRequest(URL: NSURL(string: URL))
        request.HTTPMethod = method.toRaw()
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(auth_token, forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(json: self.deserializeJSON(data), response: response, error: error)
            })
        })
        dataTask.resume()
    }
    
    
    public func upload(method: Method, URL: String, data: AnyObject, completion: (json: AnyObject!, response: NSURLResponse!, error: NSError!) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: URL))
        request.HTTPBody = self.serializeJSON(data)
        request.HTTPMethod = method.toRaw()
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(auth_token, forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            completion(json: self.deserializeJSON(data), response: response, error: error)
        })
        dataTask.resume()
    }
    
    public func serializeJSON(object: AnyObject) -> NSData {
        var error: NSError?
        return NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted, error: &error)!
    }
    
    public func deserializeJSON(data: NSData) -> AnyObject {
        var error: NSError?
        return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)!
    }
    
    public func authorizeWithCredentials(credentials: (URL: String, data: [String : String]), responseHandler: (status: Int) -> ()) {
        Manager.shared.upload(.POST, URL: credentials.URL, data: credentials.data) { (json, response, error) -> () in
            if let jsonUnwrapped = json as? [String : AnyObject] {
                if let auth_token = jsonUnwrapped["auth_token"] as AnyObject? as? String {
                    Manager.shared.auth_token = auth_token
                    NSUserDefaults.standardUserDefaults().setObject(auth_token, forKey: "auth_token")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.isAuthorized = true
                    responseHandler(status: (response as NSHTTPURLResponse).statusCode)
                }
            }
        }
    }
}