//
//  HeaderUIView.swift
//  NetflixClone
//
//  Created by BS1095 on 26/5/23.
//

import UIKit

class HeaderUIView: UIView {
    
    private let playButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false  //activate autolayout
        return button
    }()
    
    private let downloadButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false  //activate autolayout
        return button
    }()

    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "netflixBanner")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func addGradient(){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.frame = bounds
        
        layer.addSublayer(gradientLayer)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
    }
    
    private func applyConstraint(){
        
        let playButtonConstraint = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(playButtonConstraint)
        
        let downloadButtonConstraint = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(downloadButtonConstraint)
    }

}
