//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by BS1095 on 25/5/23.
//

import UIKit


enum Sections: Int {
    case TrendingMovie = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case Toprated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitle: [String] = ["Trending Movies","Trending TV","Popular","Upcoming Movies","Top Rated"]
    
    private let homeTableView: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        //table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)          //custom cell
        return table
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        configureNavbar()
        
        homeTableView.tableHeaderView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: Int(view.bounds.width), height: 450))
        homeTableView.backgroundColor = UIColor(red: 1.00, green: 0.98, blue: 0.94, alpha: 1.00)

    }
    
    
    private func configureNavbar(){
        
        var image = UIImage(named: "netflix_logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeTableView.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{      return UITableViewCell()
        }
        
        cell.delegate = self    //give access to cell delegate func
        
        switch indexPath.section{
            
        case Sections.TrendingMovie.rawValue:
            
            APICaller.shared.getTrendingMovies { result in
                switch result{
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            
            APICaller.shared.getTrendingTVs { result in
                switch result{
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            
            APICaller.shared.getPopularMovies { result in
                switch result{
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            
            APICaller.shared.getUpcomingMovies { result in
                switch result{
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Toprated.rawValue:
            
            APICaller.shared.getTopRatedMovies { result in
                switch result{
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
            
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset) )
    }
    
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellTapped(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            //navigationController?.pushViewController(TitlePreviewViewController(), animated: true)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
