//
//  ViewController.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/13.
//  Copyright © 2020 Surf. All rights reserved.
//


import UIKit


class MovieListVC: PADataLoadingVC {
    
    let tableView = UITableView()
    
    var movieName: String!
    var movies: [Movie] = []
    
    var page = 1
    var isLoadingMoreMovies = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureViewController()
        configureTableView()
        searchMovies(query: movieName, page: page)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        movies.removeAll()
    }
    
    
    init (movieName: String) {
        super.init(nibName: nil, bundle: nil)
        self.movieName = movieName
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = movieName
    }
    
    
    func searchMovies(query: String, page: Int) {
        
        showLoadingView()
        isLoadingMoreMovies = true
        
        NetworkManager.shared.searchMovie(query: query, page: page, params: nil) { (result: Result<MoviesResponse, NetworkManager.APIServiceError>) in
            self.dismissLoadingView()
    
            switch result {
            case . success(let movieResponse):
                let moviesInSearch = movieResponse.results
                self.movies.append(contentsOf: moviesInSearch)
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            case .failure(let error):
                self.presentPAAlertOnMainThread(title: "Oops", message: "No more movies by this keyword.", buttonTitle: "Ok")
                print ("\(error.localizedDescription)")
            }
            self.isLoadingMoreMovies = false
        }
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
    
}


extension MovieListVC: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let screenHeight    = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight { /// when scrolled to the very bottom
            guard !isLoadingMoreMovies else { return }
            page += 1
            searchMovies(query: movieName, page: page)
        }
    }
    
    
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie   = movies[indexPath.row]
        let destVC  = MovieScreenVC()
        destVC.movieID = movie.id
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
}


