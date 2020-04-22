//
//  FavoritesListVC.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class FavoritesListVC: PADataLoadingVC {
    
    let tableView = UITableView()
    var favoritedMovies: [FavoritedMovie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.frame             = view.bounds
        tableView.rowHeight         = 80
        tableView.removeExcessCells()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}


extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        //let favoritedMovie = favoritedMovies[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoritedMovie = favoritedMovies[indexPath.row]
        //let destVC         = MovieScreenVC()
        //navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    
    
}
