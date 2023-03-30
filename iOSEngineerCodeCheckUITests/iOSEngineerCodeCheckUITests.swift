//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class iOSEngineerCodeCheckUITestsclass: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testSearchBar() throws {
        let app = XCUIApplication()
        let searchBar = app.searchFields["GitHubのリポジトリを検索できるよー"]
        searchBar.tap()
        searchBar.typeText("swift")
        app.keyboards.buttons["Search"].tap()
        sleep(3)
        
        let tablesQuery1 = app.tables
        XCTAssertTrue(tablesQuery1.count > 0)
        
        let cellIndexPath = IndexPath(row: 0, section: 0)
        let cell = app.tables.cells.element(boundBy: cellIndexPath.row)
        
        sleep(3)
        
        cell.tap()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        let tablesQuery2 = app.tables
        XCTAssertTrue(tablesQuery2.count > 0)
        
    }
}

