//
//  HomePresenter.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation

final class HomePresenter {
    
    private weak var view: HomeViewInterface!
    private var model: HomeModel!
    
    
    init (_ view: HomeViewInterface) {
        self.view = view
        self.model = HomeModel()
        model.delegate = self
    }
    
    func searchText(_ text: String) {
    }
    
    func select(at index: Int) {
    }
}

extension HomePresenter: HomeModelDelegate {
    
    func didFetchAPIData(with error: Error?) {
        if let error = error {
            print("🥺ERROR🥺 : ", error)
        }
        view.reloadTableView()
    }
}
