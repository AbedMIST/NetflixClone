//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by BS1095 on 1/6/23.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with img:String){
        print(img)
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(img)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
