//
//  PageProtocol.swift
//  Github-APIUITests
//
//  Created by 豊岡正紘 on 2020/09/18.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//


import XCTest

protocol Page {
    init(app: XCUIApplication, timeout: TimeInterval)
}
