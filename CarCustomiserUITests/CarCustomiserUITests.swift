//
//  CarCustomiserUITests.swift
//  CarCustomiserUITests
//
//  Created by Khemaney, Akshay (SPH) on 20/01/2021.
//

import XCTest

class CarCustomiserUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBuyingPackagesChangesRemainingFunds() {
        // Arrange
        let app = XCUIApplication()
        app.launch()

        // Act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package (Cost: 500)"]/*[[".cells[\"Exhaust Package (Cost: 500)\"].switches[\"Exhaust Package (Cost: 500)\"]",".switches[\"Exhaust Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Tires Package (Cost: 500)"]/*[[".cells[\"Tires Package (Cost: 500)\"].switches[\"Tires Package (Cost: 500)\"]",".switches[\"Tires Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    
        
        // Assert
        XCTAssertEqual(app.staticTexts.element(boundBy: 1).label, "Remaining Funds: 0")
    }

    func testWhenBoughtTiresAndExhaustPackageOtherTwoUpgradesAreDisabled() throws {
        // Arrange
        let app = XCUIApplication()
        app.launch()

        // Act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package (Cost: 500)"]/*[[".cells[\"Exhaust Package (Cost: 500)\"].switches[\"Exhaust Package (Cost: 500)\"]",".switches[\"Exhaust Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Tires Package (Cost: 500)"]/*[[".cells[\"Tires Package (Cost: 500)\"].switches[\"Tires Package (Cost: 500)\"]",".switches[\"Tires Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Assert
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Brakes Package (Cost: 500)"]/*[[".cells[\"Brakes Package (Cost: 500)\"].switches[\"Brakes Package (Cost: 500)\"]",".switches[\"Brakes Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["ECU Package (Cost: 500)"]/*[[".cells[\"ECU Package (Cost: 500)\"].switches[\"ECU Package (Cost: 500)\"]",".switches[\"ECU Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isEnabled, false)
    }
    
    func testNextCarButtonResetsTogglesAndRemainingFunds() throws {
        // Arrange
        let app = XCUIApplication()
        app.launch()

        // Act
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package (Cost: 500)"]/*[[".cells[\"Exhaust Package (Cost: 500)\"].switches[\"Exhaust Package (Cost: 500)\"]",".switches[\"Exhaust Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.switches["Tires Package (Cost: 500)"]/*[[".cells[\"Tires Package (Cost: 500)\"].switches[\"Tires Package (Cost: 500)\"]",".switches[\"Tires Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells[\"Make: Mazda\\nModel: MX-5\\nTop Speed: 125mph\\nAcceleration: (0-60): 7.7s\\nHandling: 4, Next Car\"].buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    
        
        // Assert
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Exhaust Package (Cost: 500)"]/*[[".cells[\"Exhaust Package (Cost: 500)\"].switches[\"Exhaust Package (Cost: 500)\"]",".switches[\"Exhaust Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isSelected, false)
        XCTAssertEqual(tablesQuery/*@START_MENU_TOKEN@*/.switches["Tires Package (Cost: 500)"]/*[[".cells[\"Tires Package (Cost: 500)\"].switches[\"Tires Package (Cost: 500)\"]",".switches[\"Tires Package (Cost: 500)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isSelected, false)
        XCTAssertEqual(app.staticTexts.element(boundBy: 1).label, "Remaining Funds: 1,000")
    }
    
    func testNextCarButtonChangesCar() {
        // Arrange
        let app = XCUIApplication()
        app.launch()

        // Act
        app.tables/*@START_MENU_TOKEN@*/.buttons["Next Car"]/*[[".cells[\"Make: Mazda\\nModel: MX-5\\nTop Speed: 125mph\\nAcceleration: (0-60): 7.7s\\nHandling: 4, Next Car\"].buttons[\"Next Car\"]",".buttons[\"Next Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Assert
        XCTAssertEqual(app.staticTexts.element(boundBy: 3).label, "Make: Volkswagen\nModel: Golf\nTop Speed: 110mph\nAcceleration: (0-60): 6.2s\nHandling: 5")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
