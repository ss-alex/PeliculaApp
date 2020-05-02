//
//  FavoritesListVC.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {
    
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
        view.backgroundColor    = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        
        tableView.frame             = view.bounds
        tableView.rowHeight         = 140
        tableView.removeExcessCells()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func getFavorites() {
        self.showLoadingView(onView: self.view)
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
                
            case .failure(let error):
                self.presentPAAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            self.removeLoadingView()
        }
    }
    
    
    func updateUI(with favoritedMovies: [FavoritedMovie]) {
        if favoritedMovies.isEmpty {
            print ("No favorited users")
            self.showEmptyStateView(with: "No Movies?\nSearch and add a new one.", in: self.view)
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoritedMovie   = favoritedMovies[indexPath.row]
        let destVC  = MovieScreenVC()
        destVC.movieID = favoritedMovie.id
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favoritedMovie: favoritedMovies[indexPath.row], actionType: .remove) { [weak self] error in
            
            guard let self = self else { return }
            
            guard let error = error else {
                self.favoritedMovies.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentPAAlertOnMainThread(title: "Unable to remove", message: error.localizedDescription, buttonTitle: "Ok")
        }
    }
    
}


