//
//  SearchVC.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK:- Properties

    let logoImageView       = UIImageView()
    let movieTextField      = UITextField()
    let goButton            = UIButton()
    let textLabel           = UILabel()
    let categoryButtonOne   = UIButton()
    let categoryButtonTwo   = UIButton()
    let categoryButtonThree = UIButton()
    
    var isUsernameEntered: Bool { return !movieTextField.text!.isEmpty }
    
    var categoryButtons: [UIButton] = []
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PAColors.customGrayBackground.color
        
        createDismissKeyboardGesture()
        configureLogoImageView()
        configureUsernameTextField()
        configureGoButton()
        configureTextLabel()
        configureCategoryButtons()
        configureCategoryButtonTwo()
        configureCategoryButtonOne()
        configureCategoryButtonThree()
        configureCategoryButtonsLayout()
        configureLayout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
       }
    
    
    //MARK:- Methods
    
    
    func createDismissKeyboardGesture(){ 
        let tap = UITapGestureRecognizer(target: view.self, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.cornerRadius = 10
        logoImageView.image              = Images.paLogo
    }
    
    
    func configureUsernameTextField() {
        view.addSubview(movieTextField)
        movieTextField.translatesAutoresizingMaskIntoConstraints = false
        movieTextField.backgroundColor = .tertiarySystemBackground
        
        movieTextField.layer.cornerRadius  = 10
        movieTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        movieTextField.layer.borderWidth   = 2
        movieTextField.layer.borderColor   = UIColor.systemGray4.cgColor
        
        movieTextField.placeholder     = "Enter a keyword"
        movieTextField.textColor       = .label
        movieTextField.textAlignment   = .center
        movieTextField.font            = UIFont.preferredFont(forTextStyle: .title2)
        movieTextField.adjustsFontSizeToFitWidth   = true
        movieTextField.minimumFontSize             = 12
        
        movieTextField.autocorrectionType  = .no
        movieTextField.returnKeyType       = .go
        movieTextField.clearButtonMode     = .whileEditing
    }
    
    
    func configureGoButton() {
        view.addSubview(goButton)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.addTarget(self, action: #selector(pushMovieListVC), for: .touchUpInside)
        
        goButton.backgroundColor       = PAColors.customRed.color
        goButton.layer.cornerRadius    = 10
        goButton.layer.maskedCorners   = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
        goButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        goButton.setTitleColor(.white, for: .normal)
        goButton.setTitle("Go", for: .normal)
    }
        
    
    func configureTextLabel() {
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.text           = "Choose a category"
        textLabel.textColor      = .systemGray
        textLabel.font           = UIFont.systemFont(ofSize: 16, weight: .regular)
        textLabel.numberOfLines  = 1
        textLabel.textAlignment  = .left
    }
    
    
    func configureCategoryButtons() {
        categoryButtons = [categoryButtonOne,categoryButtonTwo,categoryButtonThree]
        
        for categoryButton in categoryButtons {
            view.addSubview(categoryButton)
            categoryButton.translatesAutoresizingMaskIntoConstraints = false
            
            categoryButton.titleLabel?.font   = UIFont.preferredFont(forTextStyle: .headline)
            categoryButton.setTitleColor(.white, for: .normal)
            categoryButton.backgroundColor    = UIColor.systemGray
            categoryButton.layer.borderWidth  = 1
            categoryButton.layer.borderColor  = PAColors.customGrayBackground.color.cgColor
        }
    }
    
    
    func configureCategoryButtonTwo() {
        categoryButtonTwo.addTarget(self, action: #selector(pushNowPlayingMoviesVC), for: .touchUpInside)
        categoryButtonTwo.setTitle("Now Playing", for: .normal)
    }
    
    
    func configureCategoryButtonOne() {
        categoryButtonOne.addTarget(self, action: #selector(pushPopularMoviesVC), for: .touchUpInside)
        categoryButtonOne.setTitle("Popular", for: .normal)
        categoryButtonOne.layer.cornerRadius   = 10
        categoryButtonOne.layer.maskedCorners  = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    
    func configureCategoryButtonThree() {
        categoryButtonThree.addTarget(self, action: #selector(pushTopRatedMoviesVC), for: .touchUpInside)
        categoryButtonThree.setTitle("Top Rated", for: .normal)
        categoryButtonThree.layer.cornerRadius   = 10
        categoryButtonThree.layer.maskedCorners  = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    
    func configureCategoryButtonsLayout() {
        
        NSLayoutConstraint.activate([
            categoryButtonTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryButtonTwo.topAnchor.constraint(greaterThanOrEqualTo: textLabel.bottomAnchor, constant: 7),
            categoryButtonTwo.widthAnchor.constraint(equalToConstant: 110),
            categoryButtonTwo.heightAnchor.constraint(equalToConstant: 50),
            
            categoryButtonOne.topAnchor.constraint(equalTo: categoryButtonTwo.topAnchor),
            categoryButtonOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryButtonOne.trailingAnchor.constraint(equalTo: categoryButtonTwo.leadingAnchor),
            categoryButtonOne.heightAnchor.constraint(equalToConstant: 50),
            
            categoryButtonThree.topAnchor.constraint(equalTo: categoryButtonTwo.topAnchor),
            categoryButtonThree.leadingAnchor.constraint(equalTo: categoryButtonTwo.trailingAnchor),
            categoryButtonThree.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryButtonThree.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    func configureLayout() {
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 130
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 240),
            logoImageView.heightAnchor.constraint(equalToConstant: 115),
            
            movieTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 130),
            movieTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieTextField.widthAnchor.constraint(equalToConstant: 200),
            movieTextField.heightAnchor.constraint(equalToConstant: 50),
            
            goButton.topAnchor.constraint(equalTo: movieTextField.topAnchor),
            goButton.leadingAnchor.constraint(equalTo: movieTextField.trailingAnchor),
            goButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            goButton.heightAnchor.constraint(equalToConstant: 50),
            
            textLabel.topAnchor.constraint(equalTo: movieTextField.bottomAnchor, constant: 40),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
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
                
        let movieListVC = ReusableMovieVC(state: .name(movieTextField.text!))
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    
   @objc func pushNowPlayingMoviesVC() {
        let nowPlayingMoviesVC = ReusableMovieVC(state: .category(.nowPlaying))
        navigationController?.pushViewController(nowPlayingMoviesVC, animated: true)
    }
    
    
    @objc func pushPopularMoviesVC() {
        let popularMoviesVC = ReusableMovieVC(state: .category(.popular))
        navigationController?.pushViewController(popularMoviesVC, animated: true)
    }
    
    
    @objc func pushTopRatedMoviesVC() {
        let topRatedMoviesVC = ReusableMovieVC(state: .category(.topRated))
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
