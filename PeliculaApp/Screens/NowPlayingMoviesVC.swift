//
//  LatestMoviesVC.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class NowPlayingMoviesVC: PADataLoadingVC {

    let tableView = UITableView()
    
    var movieName: String!
    var nowPlayingMovies: [Movie] = []
    
    var page = 1
    var isLoadingMoreMovies = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        fetchNowPlayingMovies(page: page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        nowPlayingMovies.removeAll()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Now Playing"
    }

    
    func configureTableView() {
        tableView.separatorColor = UIColor.clear
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.systemBackground
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func fetchNowPlayingMovies(page: Int) {
        
        showLoadingView()
        isLoadingMoreMovies = true
        
        NetworkManager.shared.fetchMovies(from: .nowPlaying, page: page) { (result: Result<MoviesResponse, NetworkManager.APIServiceError>) in
            self.dismissLoadingView()
            
            switch result {
            case .success(let movieResponse):
                print(movieResponse.results)
                let playingMovies = movieResponse.results
                self.nowPlayingMovies.append(contentsOf: playingMovies)
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.isLoadingMoreMovies = false
        }
    }

}


extension NowPlayingMoviesVC: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let screenHeight    = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard !isLoadingMoreMovies else { return }
            page += 1
            fetchNowPlayingMovies(page: page)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        
        let movie = nowPlayingMovies[indexPath.row]
        cell.set(movie: movie)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie   = nowPlayingMovies[indexPath.row]
        let destVC  = MovieScreenVC()
        destVC.movieID = movie.id
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}

