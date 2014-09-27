import UIKit
import Skoobr
import XCTest

let cell = UICollectionViewCell()
class SkoobrDataSourcesTests: XCTestCase {
    
    // the data source needs to:
    // return the correct number of sections
    
    func testDataSourceInitializing() {
        let configureCellCallback: (a: UICollectionViewCell, b: AnyObject) -> () = {(let a, let b) in }
        
        var obj = AgnosticDataSource(items: [], cellIdentifier: "foo", configureCell: configureCellCallback)
        
        XCTAssertNotNil(obj, "no nil")
    }
    
    func testNumberOfItemsInSection() {
        let configureCellCallback: (a: UICollectionViewCell, b: AnyObject) -> () = {(let a, let b) in }
        let items = ["a", "b"]
        let dataSource = AgnosticDataSource(items: items, cellIdentifier: "foo", configureCell: configureCellCallback)
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        
        let result = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        
        XCTAssertEqual(result, items.count, "should return the number of items")
    }
    
    func testCellForItemAtIndexPath() {
        var configuredCell: UICollectionViewCell? = nil
        var configuredObject: AnyObject? = nil
        let configureCellCallback: (a: UICollectionViewCell, b: AnyObject) -> () = {(let a, let b) in
            configuredCell = a
            configuredObject = b
        }
        class mockCollectionView: UICollectionView {
            override func dequeueReusableCellWithReuseIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath!) -> AnyObject {
                return cell
            }
        }
        let instance = mockCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource: AgnosticDataSource = AgnosticDataSource(items: ["a", "b"], cellIdentifier: "foo", configureCell: configureCellCallback)
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        
        let result = dataSource.collectionView(instance, cellForItemAtIndexPath: indexPath)
        
        XCTAssertEqual(result, cell, "should return the dummy cell")
        XCTAssertEqual(configuredCell!, cell, "this should have been passed to the block")
        XCTAssertEqual(configuredObject! as String, "a", "this should have been passed to the block")
    }
    
}