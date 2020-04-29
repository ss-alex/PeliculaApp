//
//  ReusableMovieVC.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/29.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class ReusableMovieVC: UIViewController {

    let tableView = UITableView()
    
    var movieName: String!
    var movies: [Movie] = []
    
    var movieCategory: String?
    var categoryMovies: [Movie] = []
    
    var page = 1
    var isLoadingMoreMovies = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionalFetchMethod ()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        movies.removeAll()
        categoryMovies.removeAll()
    }
    
    
    init (movieName: String) {
        super.init(nibName: nil, bundle: nil)
        self.movieName = movieName
    }
    
    
    init (movieCategory: String) {
        super.init(nibName: nil, bundle: nil)
        self.movieCategory = movieCategory
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    
    func conditionalFetchMethod () {
        dump(movieName)
        dump(movieCategory)
        if movieName != nil {
            self.title = movieName
            searchMovies(query: movieName, page: page)
        }
        else {
            if movieCategory == "popular" {
                self.title = "Popular"
                fetchCategoryMovies(page: page, category: "popular")
            }
            else if movieCategory == "now_playing" {
                self.title = "Now Playing"
                fetchCategoryMovies(page: page, category: "now_playing")
            } else {
                self.title = "Top Rated"
                fetchCategoryMovies(page: page, category: "top_rated")
            }
        }
    }
    
    
    func searchMovies(query: String, page: Int) {
        
        isLoadingMoreMovies = true
        NetworkManager.shared.searchMovie(query: query, page: page, params: nil) { (result: Result<MoviesResponse, NetworkManager.APIServiceError>) in

            switch result {
            case . success(let movieResponse):
                let moviesInSearch = movieResponse.results
                print ("\(moviesInSearch)")
                self.movies.append(contentsOf: moviesInSearch)
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            case .failure(let error):
                self.presentPAAlertOnMainThread(title: "Oops", message: "No more movies by this keyword.", buttonTitle: "Ok")
                print ("\(error.localizedDescription)")
            }
            self.isLoadingMoreMovies = false
        }
    }
    
    
    func fetchCategoryMovies(page: Int, category: String) {
        
        isLoadingMoreMovies = true
        NetworkManager.shared.fetchMovies(from: category, page: page) { (result: Result<MoviesResponse, NetworkManager.APIServiceError>) in
            
            switch result {
            case .success(let movieResponse):
                print(movieResponse.results)
                let movies = movieResponse.results
                print("\(movies)")
                self.categoryMovies.append(contentsOf: movies)
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.isLoadingMoreMovies = false
        }
    }
    
}


extension ReusableMovieVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieName != nil {
            return movies.count
        } else {
            return categoryMovies.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        
        if movieName != nil {
            let movie = movies[indexPath.row]
            cell.set(movie: movie)
        } else {
            let movie = categoryMovies[indexPath.row]
            cell.set(movie: movie)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let screenHeight    = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard !isLoadingMoreMovies else { return }
            page += 1
            
            if movieName != nil {
                searchMovies(query: movieName, page: page)
            }
            else {
                if movieCategory == "popular" {
                    fetchCategoryMovies(page: page, category: "popular")
                }
                else if movieCategory == "now_playing" {
                    fetchCategoryMovies(page: page, category: "now_playing")
                } else {
                    fetchCategoryMovies(page: page, category: "top_rated")
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if movieName != nil {
            let movie = movies[indexPath.row]
            let destVC  = MovieScreenVC()
            destVC.movieID = movie.id
            let navController = UINavigationController(rootViewController: destVC)
            present(navController, animated: true)
        } else {
            let movie = categoryMovies[indexPath.row]
            let destVC  = MovieScreenVC()
            destVC.movieID = movie.id
            let navController = UINavigationController(rootViewController: destVC)
            present(navController, animated: true)
        }
    }
    
}
