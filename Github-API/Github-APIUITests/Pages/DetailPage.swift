//
//  DetailPage.swift
//  Github-APIUITests
//
//  Created by 豊岡正紘 on 2020/09/18.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation

import XCTest

final class DetailPage: Page {
    
    private let app: XCUIApplication
    
    private var view: XCUIElement { self.app.otherElements["detail"] }
    
    
    init(app: XCUIApplication, timeout: TimeInterval) {
        self.app = app
        
        guard self.view.waitForExistence(timeout: timeout) else {
            fatalError("Fail to load Detail Page.")
        }
    }
    
}
