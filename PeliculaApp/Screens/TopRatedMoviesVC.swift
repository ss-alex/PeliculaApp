//
//  TopRatedMoviesVC.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class TopRatedMoviesVC: PADataLoadingVC {

    let tableView = UITableView()
    
    var movieName: String!
    var topRatedMovies: [Movie] = []
    
    var page = 1
    var isLoadingMoreMovies = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        fetchTopRatedMovies(page: page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UINavigationBar.appearance().tintColor = .systemBlue
        self.tabBarController?.tabBar.isHidden = true
        topRatedMovies.removeAll()
    }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Top Rated"
    }
    

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.systemBackground
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseID)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func fetchTopRatedMovies(page: Int) {
        showLoadingView()
        isLoadingMoreMovies = true
        
        NetworkManager.shared.fetchMovies(from: .topRated, page: page) { (result: Result<MoviesResponse, NetworkManager.APIServiceError>) in
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let movieResponse):
                print(movieResponse.results)
                let playingMovies = movieResponse.results
                self.topRatedMovies.append(contentsOf: playingMovies)
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.isLoadingMoreMovies = false
        }
    }
    

}


extension TopRatedMoviesVC: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let screenHeight    = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard !isLoadingMoreMovies else { return }
            page += 1
            fetchTopRatedMovies(page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topRatedMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        
        let movie = topRatedMovies[indexPath.row]
        cell.set(movie: movie)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie   = topRatedMovies[indexPath.row]
        let destVC  = MovieScreenVC()
        destVC.movieID = movie.id
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}


