//
//  ViewController.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import UIKit

protocol HomeViewInterface: class {
    func reloadTableView()
//    func toDetailVC(for user: )
}

class HomeViewController: UIViewController {

    private var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(self)
    }


}

extension HomeViewController: HomeViewInterface {
    
    func reloadTableView() {
    }
}
