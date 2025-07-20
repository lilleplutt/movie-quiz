import Foundation
import XCTest

final class MovieQuizUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }

    @MainActor
    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()
    }
    
    func yesTestButton() {
        sleep(3)
        let firstPoster = app.images["Poster"]
        app.buttons["Yes"].tap()
        
        sleep(3)
        let secondPoster = app.images["Poster"]
        
        XCTAssertFalse(firstPoster == secondPoster)
        XCTAssertTrue(firstPoster.exists)
        XCTAssertTrue(secondPoster.exists)
    }

}
