//
//  PopularMoviesVC.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PopularMoviesVC: UIViewController {

    let tableView = UITableView()
    
    var movieName: String!
    var popularMovies: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        fetchPopularMovies()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
     }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Popular"
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
    
    
    func fetchPopularMovies() {
        popularMovies.removeAll()
        
        MobileServiceAPI.shared.fetchMovies(from: .popular) { (result: Result<MoviesResponse, MobileServiceAPI.APIServiceError>) in
            
            switch result {
            case .success(let movieResponse):
                print(movieResponse.results)
                let playingMovies = movieResponse.results
                self.popularMovies.append(contentsOf: playingMovies)
                DispatchQueue.main.async { self.tableView.reloadData() }
                //print(self.popularMovies.first?.title)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}


extension PopularMoviesVC: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        
        let movie = popularMovies[indexPath.row]
        cell.set(movie: movie)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie   = popularMovies[indexPath.row]
        let destVC  = MovieScreenVC()
        destVC.movieID = movie.id
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}
