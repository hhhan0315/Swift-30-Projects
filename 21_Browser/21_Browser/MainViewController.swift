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
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        return webView
    }()
    
    private lazy var urlField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.7, height: 0))
        textField.placeholder = "https://"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 1
        return progressView
    }()
    
    private var backButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(touchBackButton(_:)))
        barButton.isEnabled = false
        return barButton
    }()
    
    private var forwardButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: self, action: #selector(touchForwardButton(_:)))
        barButton.isEnabled = false
        return barButton
    }()
    
    private var reloadButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(touchReloadButton(_:)))
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setNavigationBar()
        setToolBar()
        addViews()
        autoLayout()
        loadWebView(urlString: "https://www.apple.com")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            progressView.isHidden = (webView.estimatedProgress == 1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        urlField.endEditing(true)
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
    
    private func setNavigationBar() {
        navigationItem.titleView = urlField
        
        guard let titleView = navigationItem.titleView else { return }
        
        titleView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
        ])
    }
    
    private func setToolBar() {
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
        progressView.setProgress(0.0, animated: false)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "오류", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard var text = textField.text else {
            return false
        }
        
        if !text.hasPrefix("https://") {
            text.insert(contentsOf: "https://", at: text.startIndex)
        }
        
        loadWebView(urlString: text)
        
        textField.resignFirstResponder()
        return true
    }
}
