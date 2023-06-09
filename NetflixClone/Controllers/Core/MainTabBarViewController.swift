//
//  ViewController.swift
//  NetflixClone
//
//  Created by BS1095 on 25/5/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down")
        
        vc1.title = "Home"
        vc2.title = "Coming soon"
        vc3.title = "Top search"
        vc4.title = "Download"
        
        tabBar.tintColor = .label
        
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)  //control all the tabBar VC
    }


}

