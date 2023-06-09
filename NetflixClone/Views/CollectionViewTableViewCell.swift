//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by BS1095 on 26/5/23.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject{
    func collectionViewTableViewCellTapped(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {  //custom cell

    static let identifier = "CollectionViewTableViewCell"
    
    private var titles = [Movie]()
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    
    private let homeCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 190)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(homeCollectionView)
        
        homeCollectionView.backgroundColor = .black
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        homeCollectionView.frame = contentView.bounds
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func configure(with titles:[Movie]){
        self.titles = titles
        
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        guard let imageURL = titles[indexPath.row].poster_path else{
            return UICollectionViewCell()
        }
        cell.configure(with: imageURL)
        
        return cell
        
//        let imageView = UIImageView(frame: cell.bounds)
//        imageView.image = UIImage(named: "netflixBanner")
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        cell.addSubview(imageView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print(titles[indexPath.row].title)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.title else{
            return
        }
        
        APICaller.shared.getYoutubeVideo(with: titleName + " trailer") { [weak self] result in
            switch result{
            case .success(let videoElement): //need delegate ptrn to push VC
                print(videoElement.id.videoId)
                
                let title = self?.titles[indexPath.row]
                guard let titleOverview = title?.overview else{
                    return
                }
                guard let strongSelf = self else{
                    return
                }
                
                let viewModel = TitlePreviewViewModel(title: titleName, titleOverview: titleOverview, youtubeView: videoElement)
                self?.delegate?.collectionViewTableViewCellTapped(strongSelf, viewModel: viewModel)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
