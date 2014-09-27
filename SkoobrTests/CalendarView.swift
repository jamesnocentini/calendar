import Foundation
import Skoobr
import XCTest

class CalendarViewTests: XCTestCase {
    
    func testInitializerWithModel() {
        let vm = CalendarViewModel()
        var sut: CalendarViewModel
        
        let result = CalendarViewController(viewModel: vm)
        
        XCTAssertNotNil(result.viewModel, "should be a property")
    }
    
}