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
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(self)
        initializeTableView()
    }

    private func initializeTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(R.nib.searchResultCell)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.searchResultCell, for: indexPath)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchTextField.resignFirstResponder()
    }
}

extension HomeViewController: HomeViewInterface {
    
    func reloadTableView() {
    }
}
