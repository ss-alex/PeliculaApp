//
//  MovieCell.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/14.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    static let reuseID = "MovieCell"
    
    let movieImageView          = UIImageView()
    let movieTitleLabel         = UILabel()
    let movieOverview           = UILabel()
    let symbolImageView         = UIImageView()
    let dateLabel               = UILabel()
    let heartButton             = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func configureMovieImageView(){
        addSubview(movieImageView)
        movieImageView.backgroundColor = .systemFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureTitleLabel() {
        addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.text      = "Wonderful life of Alexey Kirpichnikov"
        movieTitleLabel.font      = UIFont.preferredFont(forTextStyle: .headline)
        movieTitleLabel.textColor = .label
        
        
        movieTitleLabel.numberOfLines = 2
        
    }
    
    
    private func configureMoviewOverview() {
        addSubview(movieOverview)
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        
        movieOverview.text              = "Wonderful life of Alexey Kirpichnikov Wonderful life of Alexey Kirpichnikov Wonderful life of Alexey Kirpichnikov Wonderful life of Alexey Kirpichnikov Wonderful life of Alexey Kirpichnikov Wonderful life of Alexey Kirpichnikov"
        movieOverview.font              = UIFont.preferredFont(forTextStyle: .subheadline)
        //movieOverview.font              = UIFont.preferredFont(forTextStyle: .footnote)
        movieOverview.lineBreakMode     = .byTruncatingTail
        movieOverview.numberOfLines     = 3
        movieOverview.adjustsFontForContentSizeCategory = true
        movieOverview.textColor         = .secondaryLabel
    }
    
    
    private func configureSymbolImageView() {
        addSubview(symbolImageView)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        symbolImageView.image       = UIImage(systemName: "calendar")
        symbolImageView.tintColor   = .secondaryLabel
    }
    
    
    private func configureDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.text              = "14 Feb 2020"
        dateLabel.font              = UIFont.preferredFont(forTextStyle: .footnote)
        dateLabel.textColor         = .secondaryLabel
    }
    
    
    private func configureHeartButton() {
        addSubview(heartButton)
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .systemRed
    }
    
    let padding: CGFloat = 20
    let innerPadding: CGFloat = 10
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieImageView.heightAnchor.constraint(equalToConstant: 160),
            movieImageView.widthAnchor.constraint(equalToConstant: 110),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: innerPadding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            //movieTitleLabel.heightAnchor.constraint(equalToConstant: 24),
            //movieTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            
            movieOverview.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: innerPadding),
            movieOverview.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: innerPadding),
            movieOverview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieOverview.heightAnchor.constraint(equalToConstant: 72),
            
            symbolImageView.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: innerPadding),
            symbolImageView.widthAnchor.constraint(equalToConstant: 24),
            symbolImageView.heightAnchor.constraint(equalToConstant: 24),
            
            heartButton.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            heartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            heartButton.widthAnchor.constraint(equalToConstant: 24),
            heartButton.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: innerPadding),
            dateLabel.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -innerPadding),
            dateLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    

}
