//
//  ViewController.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/13.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

import UIKit


//UI
//Network request
//tap a cell to see info about the movie
//custom cell

class ViewController: UIViewController {

    let textField = UITextField()
    let tableView = UITableView()
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        configureTableView()
        configureLayout()
        //searchMovie()
        //fetchNowPlayingMovies()
        //fetchMovieByID()
        
        
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    //Text Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovie()
        return true
    }
    
    
    func searchMovie() {
        
        textField.resignFirstResponder()
        
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        
        MobileServiceAPI.shared.searchMovie(query: "woman", params: nil) { (result: Result<MoviesResponse, MobileServiceAPI.APIServiceError>) in
            switch result {
            case . success(let movie):
                print(movie)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchNowPlayingMovies() {
        MobileServiceAPI.shared.fetchMovies(from: .nowPlaying) { (result: Result<MoviesResponse, MobileServiceAPI.APIServiceError>) in
            
            switch result {
            case .success(let movieResponse):
                print(movieResponse.results)
                let playingMovies = movieResponse.results
                self.movies.append(contentsOf: playingMovies)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchMovieByID() {
        MobileServiceAPI.shared.fetchMovie(movieID: 419704) { (result: Result<Movie, MobileServiceAPI.APIServiceError>) in
            switch result {
            case . success(let movie):
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func configureTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .gray
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray4
    }
    

    func configureLayout() {
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
}


extension ViewController: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Show movie details
    }
    
    
}


