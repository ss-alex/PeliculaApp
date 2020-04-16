//
//  ViewController.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/13.
//  Copyright © 2020 Surf. All rights reserved.
//


import UIKit

//private let reuseID = "MovieCell"

class ViewController: UIViewController {

    //let textField = UITextField()
    let tableView = UITableView()
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        configureTableView()
        
        //configureTextField()
        //configureLayout()
        
        searchMovies()
        //fetchNowPlayingMovies()
        //fetchMovieByID()
    }

    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }*/
    
    
    func searchMovies() {
        /*textField.resignFirstResponder() /// dismiss the keyboard when 'return' button is tapped
        
        guard let textInput = textField.text, !textInput.isEmpty else { return } /// textField is not empty
        let query = textInput */
        
        let query = "monster"
        
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
    }
    
    
    /*func configureTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.backgroundColor = .systemGray
    }*/
    
    
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
    
    let padding: CGFloat = 20

    /*func configureLayout() {
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }*/
    
    
    /*func fetchNowPlayingMovies() {
        MobileServiceAPI.shared.fetchMovies(from: .nowPlaying) { (result: Result<MoviesResponse, MobileServiceAPI.APIServiceError>) in
            
            switch result {
            case .success(let movieResponse):
                print(movieResponse.results)
                let playingMovies = movieResponse.results
                self.movies.append(contentsOf: playingMovies)
                
                print(self.movies.first?.title)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }*/
    
    
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




extension ViewController: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
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
    }
    
    
}


