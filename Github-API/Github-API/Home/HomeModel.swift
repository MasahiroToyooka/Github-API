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
    
    var users = [User]()
    
    func fetchUserData(_ text: String) {
        
        users = []
        
        // 検索内容がないと```Validation Failed```になってdecodeに失敗するが, データが0なので結果的にempty viewが表示される
        let urlString = "https://api.github.com/search/users?q=\(text)"
        print("url: ", urlString)
        
        guard let url = URL(string: urlString) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(Result.self, from: data)
                self.users = result.items
                self.delegate?.didFetchAPIData(with: err)
            } catch let jsonErr {
                self.delegate?.didFetchAPIData(with: jsonErr)
            }
            }.resume()
    }
}
