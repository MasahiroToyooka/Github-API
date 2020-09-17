//
//  HomeModel.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation

protocol HomeModelDelegate: class {
    func didFetchAPIData(with error: Error?)
}

final class HomeModel {
    
    weak var delegate: HomeModelDelegate?
}
