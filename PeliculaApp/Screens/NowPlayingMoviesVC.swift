//
//  LatestMoviesVC.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class NowPlayingMoviesVC: UIViewController {

    let tableView = UITableView()
    
    var movieName: String!
    var nowPlayingMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNowPlayingMovies()
        configureTableView()
        
        //searchMovies()
        //fetchMovieByID()
    }
    
    
    

    
    /*func searchMovies() {
        
        let query = movieName ?? ""
        
        movies.removeAll()
        
        MobileServiceAPI.shared.searchMovie(query: query, params: nil) { (result: Result<MoviesResponse, MobileServiceAPI.APIServiceError>) in
            switch result {
            case . success(let movieResponse):
                print(movieResponse)
                
                let moviesInSearch = movieResponse.results
                self.movies.append(contentsOf: moviesInSearch)
                
                DispatchQueue.main.async { self.tableView.reloadData() } /// UI apdate
                
                //print("\(self.movies.first?.title) means it's working")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    } */
    
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
    
    
    func fetchNowPlayingMovies() {
        nowPlayingMovies.removeAll()
        
        MobileServiceAPI.shared.fetchMovies(from: .nowPlaying) { (result: Result<MoviesResponse, MobileServiceAPI.APIServiceError>) in
            
            switch result {
            case .success(let movieResponse):
                print(movieResponse.results)
                let playingMovies = movieResponse.results
                self.nowPlayingMovies.append(contentsOf: playingMovies)
                //print(self.nowPlayingMovies.first?.title)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    /*func fetchMovieByID() {
        MobileServiceAPI.shared.fetchMovie(movieID: 419704) { (result: Result<Movie, MobileServiceAPI.APIServiceError>) in
            switch result {
            case . success(let movie):
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }*/

}


extension NowPlayingMoviesVC: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
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
    }
    
}

