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
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame             = view.bounds
        tableView.rowHeight         = 140
        tableView.removeExcessCells()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                self.presentPAAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func updateUI(with favoritedMovies: [FavoritedMovie]) {
        if favoritedMovies.isEmpty {
            print ("No favorited users")
        } else {
            self.favoritedMovies = favoritedMovies
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
    
}


extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        
        let favoritedMovie = favoritedMovies[indexPath.row]
        cell.setTextAndImageFor(favorite: favoritedMovie)
        
        return cell
    }
    
    
}


