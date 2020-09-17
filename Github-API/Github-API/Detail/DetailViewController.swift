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
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var goFowardButton: UIButton!
    
    var user: User?
    
    let progressView = UIProgressView(progressViewStyle: .default)
    private var estimatedProgressObserver: NSKeyValueObservation?


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
        setupProgressView()
        setupEstimatedProgressObserver()
    }

    deinit {
        print("deinit")
        estimatedProgressObserver = nil
        progressView.removeFromSuperview()
    }
    
    private func setupWebView() {
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        self.wkWebView.scrollView.bounces = true
        let refreshControl = UIRefreshControl()
        self.wkWebView.scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(DetailViewController.refreshWebView(sender:)), for: .valueChanged)
    }
    
    @objc func refreshWebView(sender: UIRefreshControl) {
        reload()
        sender.endRefreshing()
    }
    
    private func setupProgressView() {
        guard let navigationBar = navigationController?.navigationBar else { return }

        progressView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(progressView)
        progressView.isHidden = true

        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),

            progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }
    
    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = wkWebView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    private func load() {
        guard let urlString = user?.htmlUrl, let url = URL(string: urlString) else {
            showFailMessage()
            return
        }
        let request = URLRequest(url: url)
        wkWebView.load(request)
    }
    
    private func reload() {
        guard let urlString = user?.htmlUrl, let url = URL(string: urlString) else {
            showFailMessage()
            return
        }
        if wkWebView.url != nil {
            wkWebView.reload()
        } else {
            wkWebView.load(URLRequest(url: url))
        }
    }
    
    private func showFailMessage() {
        let html = "<html><head><title>エラー</title><meta charset='UTF-8'></head><body><h1>Webページを表示できません</h1></body></html>"
        wkWebView.loadHTMLString(html, baseURL: nil)
    }
    
    private func changeButtonState() {
        goFowardButton.tintColor = wkWebView.canGoForward ? .black : .lightGray
        goBackButton.tintColor = wkWebView.canGoBack ? .black : .lightGray
    }
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        if wkWebView.canGoBack {
            wkWebView.goBack()
        }
    }
    
    @IBAction func goFowardButtonTapped(_ sender: UIButton) {
        if wkWebView.canGoForward {
            wkWebView.goForward()
        }
    }
}

// MARK: - WKNavigationDelegate
extension DetailViewController: WKNavigationDelegate {
    
    // 読み込み設定（リクエスト前）
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("読み込み設定（リクエスト前）")
        guard let url = navigationAction.request.url else { return }
        print("開くurl: ", url)
        let app = UIApplication.shared
        
        if URLSchemeType(scheme: url.scheme) != nil {
            if app.canOpenURL(url) {
                app.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    // 読み込み準備開始
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if progressView.isHidden {
            progressView.isHidden = false
        }

        UIView.animate(withDuration: 0.33, animations: {
            self.progressView.alpha = 1.0
        })
        print("読み込み準備開始")
    }
    
    // 読み込み完了
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIView.animate(withDuration: 0.33,
                       animations: {
                           self.progressView.alpha = 0.0
                       },
                       completion: { isFinished in
                           self.progressView.isHidden = isFinished
        })
        changeButtonState()
        print("読み込み完了")
    }
    
    // WebPageの読み込み開始時にerrorが起きた時に呼ばれる
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError: Error) {
        print("読み込み失敗検知")
        // ユーザーキャンセルによるエラー無視する
        if ((withError as NSError)).code != NSURLErrorCancelled {
            showFailMessage()
        }
        changeButtonState()
        self.progressView.isHidden = true
    }
    
    // WebPageの読み込み途中でerrorが起きた時に呼ばれる
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError: Error) {
        print("読み込み失敗")
        // ユーザーキャンセルによるエラー無視する
        if ((withError as NSError)).code != NSURLErrorCancelled {
            showFailMessage()
        }
        changeButtonState()
        self.progressView.isHidden = true
    }
}

// MARK: - WKUIDelegate jsとの連携
extension DetailViewController: WKUIDelegate {
    
    // target=_blank対策
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
