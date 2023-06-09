//
//  TitleTableViewCell.swift
//  NetflixClone
//
//  Created by BS1095 on 6/6/23.
//

import UIKit
import SDWebImage

class TitleTableViewCell: UITableViewCell {   //custom cell

    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let img = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(img, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false  //activate autolayout
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    public func configure(with model: TitleViewModel){
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else{
            return
        }
        titlePosterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    private func applyConstraint(){
        
        let titlePosterImageViewConstraint = [
            titlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(titlePosterImageViewConstraint)
        
        let titleLabelConstraint = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(titleLabelConstraint)
        
        let playTitleButtonConstraint = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(playTitleButtonConstraint)
    }

}
