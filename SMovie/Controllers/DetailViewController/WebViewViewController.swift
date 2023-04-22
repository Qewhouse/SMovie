//
//  WebViewViewController.swift
//  SMovie
//
//  Created by Eduard Tokarev on 22.04.2023.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController {
    private var idYouTube = ""
    private let webView = WKWebView()
    private let networkService = NetworkService.shared
    
    init(idYouTube: String) {
        self.idYouTube = idYouTube
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ArrowBack"), style: .plain, target: self, action: #selector(addTappedLeftNavButton))
        
        addSubviews()
        addViewConstraints()
        networkService.fetchVideo(idVideo: idYouTube) { [weak self] player in
            guard
                let self = self,
                let embedHtml = player?.embedHtml else { return }
            print(embedHtml)
            let httpsEmbedHtml = embedHtml.replacingOccurrences(of: "src=\"", with: "src=\"https:")
            print(httpsEmbedHtml)
            self.webView.loadHTMLString("<!DOCTYPE html><html><body>\(httpsEmbedHtml)</body></html>", baseURL: nil)
        }
    }
    
    private func addSubviews() {
        [webView].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
    }
    
    private func addViewConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func addTappedLeftNavButton() {
        dismiss(animated: true)
    }
}
