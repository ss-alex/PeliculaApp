//
//  SearchVC.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView       = UIImageView()
    let movieTextField      = UITextField()
    let goButton            = UIButton()
    let categoryButtonOne   = PAButton(backgroundColor: .systemGray4, tittle: "Now Playing")
    let categoryButtonTwo   = PAButton(backgroundColor: .systemGray4, tittle: "Popular")
    let categoryButtonThree = PAButton(backgroundColor: .systemGray4, tittle: "Top Rated")
    let categoryButtonFour  = PAButton(backgroundColor: .systemGray4, tittle: "Upcoming")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureUsernameTextField()
        configureGoButton()
        configureCategoryButtons()
        configureLayout()
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.backgroundColor    = .systemBackground
        logoImageView.layer.borderWidth  = 2
        logoImageView.layer.borderColor  = UIColor.systemGray3.cgColor
        logoImageView.layer.cornerRadius = 10
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureUsernameTextField() {
        view.addSubview(movieTextField)
        movieTextField.translatesAutoresizingMaskIntoConstraints = false
        movieTextField.backgroundColor = .tertiarySystemBackground
        
        movieTextField.layer.cornerRadius  = 10
        movieTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        movieTextField.layer.borderWidth   = 2
        movieTextField.layer.borderColor   = UIColor.systemGray4.cgColor
        
        movieTextField.placeholder    = "Enter a movie"
        movieTextField.textColor      = .label
        movieTextField.textAlignment  = .center
        movieTextField.font           = UIFont.preferredFont(forTextStyle: .title2)
        movieTextField.adjustsFontSizeToFitWidth = true
        movieTextField.minimumFontSize           = 12
        
        movieTextField.autocorrectionType  = .no
        movieTextField.returnKeyType       = .go
        movieTextField.clearButtonMode     = .whileEditing
    }
    
    
    func configureGoButton() {
        view.addSubview(goButton)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        
        goButton.backgroundColor       = .systemBlue
        goButton.layer.cornerRadius    = 10
        goButton.layer.maskedCorners   = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
        goButton.titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        goButton.setTitleColor(.white, for: .normal)
        goButton.setTitle("Go", for: .normal)
        
        goButton.addTarget(self, action: #selector(pushMovieListVC), for: .touchUpInside)
    }
    
    
    @objc func pushMovieListVC() {
        let movieListVC = MovieListVC(movieName: movieTextField.text!)
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    
    let outerPadding: CGFloat = 40
    let categoryButtonWidth: CGFloat = 136
    
    func configureCategoryButtons() {
        view.addSubview(categoryButtonOne)
        categoryButtonOne.addTarget(self, action: #selector(pushNowPlayingMoviesVC), for: .touchUpInside)
        
        view.addSubview(categoryButtonTwo)
        categoryButtonTwo.addTarget(self, action: #selector(pushPopularMoviesVC), for: .touchUpInside)
        
        view.addSubview(categoryButtonThree)
        categoryButtonThree.addTarget(self, action: #selector(pushTopRatedMoviesVC), for: .touchUpInside)
        
        view.addSubview(categoryButtonFour)
        categoryButtonFour.addTarget(self, action: #selector(pushUpcomingMoviesVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            categoryButtonOne.topAnchor.constraint(equalTo: movieTextField.bottomAnchor, constant: 80),
            categoryButtonOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
            categoryButtonOne.widthAnchor.constraint(equalToConstant: categoryButtonWidth),
            categoryButtonOne.heightAnchor.constraint(equalToConstant: 50),
            
            categoryButtonTwo.topAnchor.constraint(equalTo: categoryButtonOne.topAnchor),
            categoryButtonTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
            categoryButtonTwo.widthAnchor.constraint(equalToConstant: categoryButtonWidth),
            categoryButtonTwo.heightAnchor.constraint(equalToConstant: 50),
            
            categoryButtonThree.topAnchor.constraint(equalTo: categoryButtonOne.bottomAnchor, constant: 38),
            categoryButtonThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
            categoryButtonThree.widthAnchor.constraint(equalToConstant: categoryButtonWidth),
            categoryButtonThree.heightAnchor.constraint(equalToConstant: 50),
            
            categoryButtonFour.topAnchor.constraint(equalTo: categoryButtonThree.topAnchor),
            categoryButtonFour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
            categoryButtonFour.widthAnchor.constraint(equalToConstant: categoryButtonWidth),
            categoryButtonFour.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }

    
    @objc func pushNowPlayingMoviesVC() {
        let latestMoviesVC = NowPlayingMoviesVC()
        navigationController?.pushViewController(latestMoviesVC, animated: true)
    }
    
    
    @objc func pushPopularMoviesVC() {
        let populaerMoviesVC = PopularMoviesVC()
        navigationController?.pushViewController(populaerMoviesVC, animated: true)
    }
    
    
    @objc func pushTopRatedMoviesVC() {
        let topRatedMoviesVC = TopRatedMoviesVC()
        navigationController?.pushViewController(topRatedMoviesVC, animated: true)
    }
    
    
    @objc func pushUpcomingMoviesVC() {
        let upcomingMoviesVC = UpcomingMoviesVC()
        navigationController?.pushViewController(upcomingMoviesVC, animated: true)
    }
    
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 180),
            logoImageView.heightAnchor.constraint(equalToConstant: 180),
            
            movieTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            movieTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            movieTextField.widthAnchor.constraint(equalToConstant: 200),
            movieTextField.heightAnchor.constraint(equalToConstant: 50),
            
            goButton.topAnchor.constraint(equalTo: movieTextField.topAnchor),
            goButton.leadingAnchor.constraint(equalTo: movieTextField.trailingAnchor),
            goButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            goButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
