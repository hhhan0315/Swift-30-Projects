//
//  MainViewController.swift
//  21_Browser
//
//  Created by rae on 2022/01/01.
//

import UIKit
import WebKit

class MainViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    //    private let progressView: UIProgressView = {
    //        let progressView = UIProgressView()
    //        progressView.translatesAutoresizingMaskIntoConstraints = false
    //        progressView.backgroundColor = .red
    //        return progressView
    //    }()
    
    private var backButton = UIBarButtonItem()
    private var forwardButton = UIBarButtonItem()
    private var reloadButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setToolBar()
        addViews()
        autoLayout()
        loadWebView(urlString: "https://www.apple.com")
    }
    
    private func addViews() {
        view.addSubview(webView)
    }
    
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: guide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    private func loadWebView(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    private func setToolBar() {
        backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(touchBackButton(_:)))
        forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: self, action: #selector(touchForwardButton(_:)))
        reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(touchReloadButton(_:)))
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        let toolBarItems = [backButton, forwardButton, flexibleSpace, reloadButton]
        
        navigationController?.isToolbarHidden = false
        self.setToolbarItems(toolBarItems, animated: false)
    }
    
    @objc func touchBackButton(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @objc func touchForwardButton(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @objc func touchReloadButton(_ sender: UIBarButtonItem) {
        webView.reload()
    }
}

extension MainViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
