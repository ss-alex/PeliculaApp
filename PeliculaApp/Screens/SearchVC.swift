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
    let textLabel           = UILabel()
    let categoryButtonOne   = UIButton()
    let categoryButtonTwo   = UIButton()
    let categoryButtonThree = UIButton()
    
    var isUsernameEntered: Bool { return !movieTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        createDismissKeyboardGesture()
        configureLogoImageView()
        configureUsernameTextField()
        configureGoButton()
        configureTextLabel()
        configureCategoryButtonTwo()
        configureCategoryButtonOne()
        configureCategoryButtonThree()
        configureCategoryButtons()
        configureLayout()
    }
    
    
    func createDismissKeyboardGesture(){ 
        let tap = UITapGestureRecognizer(target: view.self, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.backgroundColor    = .systemBackground
        logoImageView.layer.borderWidth  = 2
        logoImageView.layer.borderColor  = UIColor.systemGray3.cgColor
        logoImageView.layer.cornerRadius = 10
    }
    
    
    func configureUsernameTextField() {
        view.addSubview(movieTextField)
        movieTextField.translatesAutoresizingMaskIntoConstraints = false
        movieTextField.backgroundColor = .tertiarySystemBackground
        
        movieTextField.layer.cornerRadius  = 10
        movieTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        movieTextField.layer.borderWidth   = 2
        movieTextField.layer.borderColor   = UIColor.systemGray4.cgColor
        
        movieTextField.placeholder    = "Enter a keyword"
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
        goButton.addTarget(self, action: #selector(pushMovieListVC), for: .touchUpInside)
        
        goButton.backgroundColor       = .systemBlue
        goButton.layer.cornerRadius    = 10
        goButton.layer.maskedCorners   = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
        goButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        goButton.setTitle("Go", for: .normal)
        goButton.setTitleColor(.white, for: .normal)
    }
        
    
    func configureTextLabel() {
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.text           = "Choose a category"
        textLabel.textColor      = .systemGray
        textLabel.font           = UIFont.systemFont(ofSize: 16, weight: .light)
        textLabel.numberOfLines  = 1
        textLabel.textAlignment  = .left
    }
    
    
    
    func configureCategoryButtonTwo() {
        view.addSubview(categoryButtonTwo)
        categoryButtonTwo.translatesAutoresizingMaskIntoConstraints = false
        categoryButtonTwo.addTarget(self, action: #selector(pushNowPlayingMoviesVC), for: .touchUpInside)
        
        categoryButtonTwo.setTitle("Now Playing", for: .normal)
        categoryButtonTwo.setTitleColor(.systemBlue, for: .normal)
        categoryButtonTwo.titleLabel?.font    = UIFont.preferredFont(forTextStyle: .headline)
        categoryButtonTwo.backgroundColor     = .systemGray4
        categoryButtonTwo.layer.borderWidth   = 1
        categoryButtonTwo.layer.borderColor   = UIColor.systemBackground.cgColor
    }
    
    
    func configureCategoryButtonOne() {
        view.addSubview(categoryButtonOne)
        categoryButtonOne.translatesAutoresizingMaskIntoConstraints = false
        categoryButtonOne.addTarget(self, action: #selector(pushPopularMoviesVC), for: .touchUpInside)
        
        categoryButtonOne.setTitle("Popular", for: .normal)
        categoryButtonOne.setTitleColor(.systemBlue, for: .normal)
        categoryButtonOne.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        categoryButtonOne.backgroundColor  = .systemGray4
        
        categoryButtonOne.layer.borderWidth    = 1
        categoryButtonOne.layer.borderColor    = UIColor.systemBackground.cgColor
        categoryButtonOne.layer.cornerRadius   = 10
        categoryButtonOne.layer.maskedCorners  = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    
    func configureCategoryButtonThree() {
        view.addSubview(categoryButtonThree)
        categoryButtonThree.translatesAutoresizingMaskIntoConstraints = false
        categoryButtonThree.addTarget(self, action: #selector(pushTopRatedMoviesVC), for: .touchUpInside)
        
        categoryButtonThree.setTitle("Top Rated", for: .normal)
        categoryButtonThree.setTitleColor(.systemBlue, for: .normal)
        categoryButtonThree.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        categoryButtonThree.backgroundColor  = .systemGray4
        
        categoryButtonThree.layer.borderWidth    = 1
        categoryButtonThree.layer.borderColor    = UIColor.systemBackground.cgColor
        categoryButtonThree.layer.cornerRadius   = 10
        categoryButtonThree.layer.maskedCorners  = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    
    
    func configureCategoryButtons() {
        
        NSLayoutConstraint.activate([
            categoryButtonTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryButtonTwo.topAnchor.constraint(greaterThanOrEqualTo: textLabel.bottomAnchor, constant: 10),
            categoryButtonTwo.widthAnchor.constraint(equalToConstant: 110),
            categoryButtonTwo.heightAnchor.constraint(equalToConstant: 50),
            
            categoryButtonOne.topAnchor.constraint(equalTo: categoryButtonTwo.topAnchor),
            categoryButtonOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            categoryButtonOne.trailingAnchor.constraint(equalTo: categoryButtonTwo.leadingAnchor),
            categoryButtonOne.heightAnchor.constraint(equalToConstant: 50),
            
            categoryButtonThree.topAnchor.constraint(equalTo: categoryButtonTwo.topAnchor),
            categoryButtonThree.leadingAnchor.constraint(equalTo: categoryButtonTwo.trailingAnchor),
            categoryButtonThree.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            categoryButtonThree.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    func configureLayout() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
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
            goButton.heightAnchor.constraint(equalToConstant: 50),
            
            textLabel.topAnchor.constraint(equalTo: movieTextField.bottomAnchor, constant: 60),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    //MARK:- @objc Methods
    
    @objc func pushMovieListVC() {
        
        guard isUsernameEntered else {
            presentPAAlertOnMainThread(title: "Empty Keyword", message: "Please enter a keyword. We need to know what to look for.", buttonTitle: "Ok")
            return
        }
        view.endEditing(true)
        
        let movieListVC = MovieListVC(movieName: movieTextField.text!)
        navigationController?.pushViewController(movieListVC, animated: true)
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
    
}

//MARK:- Extensions


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushMovieListVC()
        return true
    }
}
