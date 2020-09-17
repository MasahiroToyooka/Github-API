//
//  HomePage.swift
//  Github-APIUITests
//
//  Created by 豊岡正紘 on 2020/09/18.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import XCTest

final class HomePage: Page {
    
    private let app: XCUIApplication
    
    private var view: XCUIElement { self.app.otherElements["home"] }
    private var searchTextField: XCUIElement { self.view.textFields["home_search_textfield"] }
    private var resultTableViewFirstCell: XCUIElement { self.view.tables.cells.element(boundBy: 0) }
    private var resultTableViewFirstCell_LoginLabel: XCUIElement { self.resultTableViewFirstCell.staticTexts["resultCell_loginName_Label"] }
    
    
    init(app: XCUIApplication, timeout: TimeInterval) {
        self.app = app
    }
    
    func inputSearchText(searchText: String) -> HomePage {
        searchTextField.inputText(searchText)
        return self
    }
    
    func swipeUpTableViewFirstCell() -> HomePage {
        self.resultTableViewFirstCell.swipeUp()
        return self
    }
    
    func swipeDownTableViewFirstCell() -> HomePage {
        self.resultTableViewFirstCell.swipeDown()
        return self
    }
    
    func resultTableViewFirstCell_LoginLabelText() -> String {
        return resultTableViewFirstCell_LoginLabel.label
    }
    
    func tapFirstCell() -> DetailPage {
        self.resultTableViewFirstCell.tapIfExists()
        return DetailPage(app: self.app, timeout: 2.0)
    }
}
