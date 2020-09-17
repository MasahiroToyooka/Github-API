//
//  Github_APIUITests.swift
//  Github-APIUITests
//
//  Created by 豊岡正紘 on 2020/09/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import XCTest

final class Github_APIUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //　検索して詳細ページに遷移できるかどうか
    func testTransitionDetail() throws {
        let app = XCUIApplication()
        app.launch()

        let homePage = HomePage(app: app, timeout: 3.0)
        let searchText = "Masa"
        
        _ = homePage
            .inputSearchText(searchText: searchText)
            .tapFirstCell()
        
    }
    
    // 検索結果が意図した結果になっているかどうか
    func testAPIRespose() throws {
        let app = XCUIApplication()
        app.launch()
        
        let homePage = HomePage(app: app, timeout: 3.0)
        let searchText = "MasahiroToyooka"
        let correctText = "MasahiroToyooka"
                
        let resultLabel = homePage
            .inputSearchText(searchText: searchText)
            .swipeUpTableViewFirstCell()
            .swipeDownTableViewFirstCell()
            .resultTableViewFirstCell_LoginLabelText()
        
        XCTAssertEqual(resultLabel, correctText)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
