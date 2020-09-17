//
//  ViewController.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import UIKit
import Combine

protocol HomeViewInterface: class {
    func reloadTableView()
//    func toDetailVC(for user: )
}

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var presenter: HomePresenter!
    private var listener: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(self)
        initializeTableView()
        initializeSearchTextField()
    }

    private func initializeTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(R.nib.searchResultCell)
    }
    
    private func initializeSearchTextField() {
        searchTextField.delegate = self
        
        listener = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: searchTextField)
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .sink { [weak self] (_) in
                
                if let searchText = self?.searchTextField.text {
                    self?.resultTableView.isUserInteractionEnabled = false
                    self?.presenter.searchText(searchText)
                }
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.searchResultCell, for: indexPath)!
        cell.configure(data: presenter.searchResults[indexPath.row])
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
        DispatchQueue.main.sync {
            UIView.animate(withDuration: 0, animations: {
                self.resultTableView.reloadData()
            }) { _ in
                self.resultTableView.isUserInteractionEnabled = true
            }
        }
    }
}
