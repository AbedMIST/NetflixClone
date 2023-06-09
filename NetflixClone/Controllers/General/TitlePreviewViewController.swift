//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by BS1095 on 7/6/23.
//

import UIKit
import WebKit   //for webView


class TitlePreviewViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Harry Potter"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is the best movie ever to watch as a cruel kid we all know."
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false  //activate autolayout
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        applyConstraint()
    }
    
    public func configure(with model: TitlePreviewViewModel){  //config from API
        
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        //load youtube video on webView
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(model.youtubeView.id.videoId)") else{
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    
    
    private func applyConstraint(){
        
        let webViewConstraint = [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 240)
        ]
        NSLayoutConstraint.activate(webViewConstraint)
        
        let titleLabelConstraint = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(titleLabelConstraint)
        
        let overviewLabelConstraint = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(overviewLabelConstraint)
        
        let downloadButtonConstraint = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(downloadButtonConstraint)
        
    }

}
