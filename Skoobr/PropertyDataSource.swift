import UIKit

public class CalendarPropertyDataSource: NSObject, UITableViewDataSource {
    let cellIdentifier: String
    let properties: [Property]
    
    init(properties: [Property], cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
        self.properties = properties
        super.init()
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        if !(cell != nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        cell.textLabel!.text = properties[indexPath.item].name
        cell.textLabel!.font = UIFont.boldSystemFontOfSize(12.0)
        return cell
    }
    
}