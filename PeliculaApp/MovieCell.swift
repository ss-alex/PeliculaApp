//
//  MovieCell.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/14.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    static let reuseID = "MovieCell"
    
    let backView = UIView()
    
    let movieImageView    = UIImageView()
    let movieTitleLabel   = UILabel()
    let movieOverview     = UILabel()
    let symbolImageView   = UIImageView()
    let dateLabel         = UILabel()
    let heartButton       = UIButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureBackView()
        configureMovieImageView()
        configureMovieTitleLabel()
        configureMovieOverview ()
        configureSymbolImageView()
        configureDateLabel()
        configureHeartButton()
        
        configureElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    
    func set(movie: Movie) {
        movieImageView.load(url: movie.posterURL)
        movieTitleLabel.text    = movie.title
        movieOverview.text      = movie.overview
        dateLabel.text          = MovieCell.dateFormatter.string(from: movie.releaseDate)
    }
    
    
    func configureBackView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = .systemGray6
        backView.layer.cornerRadius = 5
        addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ])
    }
    
    
    func configureMovieImageView() {
        backView.addSubview(movieImageView)
        movieImageView.backgroundColor = .green
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureMovieTitleLabel() {
        backView.addSubview(movieTitleLabel)
        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureMovieOverview () {
        backView.addSubview(movieOverview)
        movieOverview.font              = UIFont.preferredFont(forTextStyle: .subheadline)
        movieOverview.lineBreakMode     = .byTruncatingTail
        movieOverview.numberOfLines     = 3
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureSymbolImageView() {
        backView.addSubview(symbolImageView)
        symbolImageView.image = UIImage(systemName: "calendar")
        symbolImageView.tintColor = .secondaryLabel
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureDateLabel() {
        backView.addSubview(dateLabel)
        dateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        dateLabel.textColor = .secondaryLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureHeartButton() {
        backView.addSubview(heartButton)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .systemRed
        heartButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    let innerPadding: CGFloat = 10
    let outerPadding: CGFloat = 4
    
    func configureElements() {
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: outerPadding),
            movieImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: outerPadding),
            movieImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -outerPadding),
            movieImageView.widthAnchor.constraint(equalToConstant: 110),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: innerPadding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            
            movieOverview.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 6),
            movieOverview.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: innerPadding),
            movieOverview.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -outerPadding),
            movieOverview.heightAnchor.constraint(equalToConstant: 62),
            
            symbolImageView.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: innerPadding),
            symbolImageView.widthAnchor.constraint(equalToConstant: 24),
            symbolImageView.heightAnchor.constraint(equalToConstant: 24),
            
            heartButton.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            heartButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -outerPadding),
            heartButton.widthAnchor.constraint(equalToConstant: 24),
            heartButton.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: innerPadding),
            dateLabel.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -innerPadding),
            dateLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
