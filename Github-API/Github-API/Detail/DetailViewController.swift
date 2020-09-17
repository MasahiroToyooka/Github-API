//
//  DetailViewController.swift
//  Github-API
//
//  Created by 豊岡正紘 on 2020/09/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var wkWebView: WKWebView!
    
    var user: User?

    static func instantiate(user: User?) -> DetailViewController {
        let vc = R.storyboard.main.detail()!
        vc.user = user
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            self.navigationItem.title = user.login
        }
        
        setupWebView()
        load()
    }
    
    private func setupWebView() {

        wkWebView.allowsBackForwardNavigationGestures = true
    }
    
    private func load() {
        guard let urlString = user?.htmlUrl, let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        wkWebView.load(request)
    }
}
