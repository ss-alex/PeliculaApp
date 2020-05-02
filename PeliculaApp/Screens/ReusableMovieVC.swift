//
//  ReusableMovieVC.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/29.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class ReusableMovieVC: UIViewController {
    
    enum State {
        case name(String)
        case category(MovieCategory)
    }
    

    let tableView = UITableView()
    var state: State
    var movies: [Movie] = []
    
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
    }
    
    
    init (state: State) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
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
        dump(state)
        
        switch state {
        case .name(let movieName):
            self.title = movieName
            searchMovies(query: movieName, page: page)
        case .category(let movieCategory):
            self.title = movieCategory.title
            fetchCategoryMovies(page: page, category: movieCategory.rawValue)
        }
    }
    
    
    func searchMovies(query: String, page: Int) {
        isLoadingMoreMovies = true
        self.showLoadingView(onView: self.view)
        
        NetworkManager.shared.searchMovie(query: query, page: page, params: nil) { (result: Result<MoviesResponse, PAError>) in
            switch result {
            case . success(let movieResponse):
                self.removeLoadingView()
                
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
        self.showLoadingView(onView: self.view)
        
        NetworkManager.shared.fetchMovies(from: category, page: page) { (result: Result<MoviesResponse, PAError>) in
            
            switch result {
            case .success(let movieResponse):
                print(movieResponse.results)
                let movies = movieResponse.results
                print("\(movies)")
                self.movies.append(contentsOf: movies)
                DispatchQueue.main.async { self.tableView.reloadData() }
                                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.isLoadingMoreMovies = false
            self.removeLoadingView()
        }
    }
    
}


extension ReusableMovieVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
                
        let movie = movies[indexPath.row]
        cell.set(movie: movie)
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
            
            switch state {
            case .name(let movieName):
                searchMovies(query: movieName, page: page)
            case .category(let movieCategory):
                fetchCategoryMovies(page: page, category: movieCategory.rawValue)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let movie = movies[indexPath.row]
        let destVC  = MovieScreenVC()
        destVC.movieID = movie.id
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}
