//
//  XCUIElement.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/18.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import XCTest
import Foundation

extension XCUIElement {
    func tapIfExists(timeout: Double = 10) {
        if self.waitForExistence(timeout: timeout) {
            self.tap()
        }
    }
    
    func lazyTap(time: uint = 1) {
        sleep(time)
        self.tap()
    }
    
    func inputText(_ text: String) {
        self.tap()
        self.typeText(text)
    }
}
