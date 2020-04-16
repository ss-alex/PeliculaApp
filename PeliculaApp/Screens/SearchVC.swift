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
    let usernameTextField   = UITextField()
    let goButton            = UIButton()
    let categoryButtonOne   = PAButton(backgroundColor: .systemGray4, tittle: "Latest")
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
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.backgroundColor = .tertiarySystemBackground
        
        usernameTextField.layer.cornerRadius    = 10
        usernameTextField.layer.maskedCorners   = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        usernameTextField.layer.borderWidth     = 2
        usernameTextField.layer.borderColor     = UIColor.systemGray4.cgColor
        
        usernameTextField.placeholder                 = "Enter a movie"
        usernameTextField.textColor                   = .label
        usernameTextField.textAlignment               = .center
        usernameTextField.font                        = UIFont.preferredFont(forTextStyle: .title2)
        usernameTextField.adjustsFontSizeToFitWidth   = true
        usernameTextField.minimumFontSize             = 12
        
        usernameTextField.autocorrectionType  = .no
        usernameTextField.returnKeyType       = .go
        usernameTextField.clearButtonMode     = .whileEditing
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
    }
    
    
    let outerPadding: CGFloat = 40
    let categoryButtonWidth: CGFloat = 136
    
    func configureCategoryButtons() {
        view.addSubview(categoryButtonOne)
        view.addSubview(categoryButtonTwo)
        view.addSubview(categoryButtonThree)
        view.addSubview(categoryButtonFour)
        
        NSLayoutConstraint.activate([
            categoryButtonOne.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 80),
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

    
    func configureLayout() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 180),
            logoImageView.heightAnchor.constraint(equalToConstant: 180),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            goButton.topAnchor.constraint(equalTo: usernameTextField.topAnchor),
            goButton.leadingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            goButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            goButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
