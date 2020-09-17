//
//  ViewController.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import UIKit
import Combine
import DZNEmptyDataSet

protocol HomeViewInterface: class {
    func reloadTableView()
    func toDetailVC(for user: User)
}

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var presenter: HomePresenter!
    private var listener: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search User"
        
        presenter = HomePresenter(self)
        initializeTableView()
        initializeSearchTextField()
    }

    private func initializeTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.emptyDataSetSource = self
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.select(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
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
    func toDetailVC(for user: User) {
        let vc = DetailViewController.instantiate(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
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


// MARK: - Empty View
extension HomeViewController: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "一致する検索結果は\nありません".attribute().font(.systemFont(ofSize: 25)).textColor(.lightGray)
        return str
    }
    
    // empty viewの表示場所の指定
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -100
    }
}
