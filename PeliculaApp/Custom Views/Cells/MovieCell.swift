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

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureBackView()
        configureMovieImageView()
        configureMovieTitleLabel()
        configureMovieOverview ()
        configureSymbolImageView()
        configureDateLabel()
        
        configureElements()
        
        self.backgroundColor = PAColors.customGrayBackground.color
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
        NetworkManager.shared.downloadImage(url: movie.posterURL) { image in
            self.movieImageView.image = image
        }
        movieTitleLabel.text   = movie.title
        movieOverview.text     = movie.overview
        dateLabel.text         = MovieCell.dateFormatter.string(from: movie.releaseDate)
    }
    
    
    func configureBackView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor    = .systemGray4
        backView.layer.cornerRadius = 10
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
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.backgroundColor      = .systemGray3
        movieImageView.layer.cornerRadius   = 10
        movieImageView.clipsToBounds        = true
        movieImageView.contentMode          = .scaleAspectFit
        movieImageView.image                = Images.moviePosterPlaceholder
    }
    
    
    func configureMovieTitleLabel() {
        backView.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.numberOfLines   = 2
        movieTitleLabel.font            = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    func configureMovieOverview () {
        backView.addSubview(movieOverview)
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.lineBreakMode   = .byTruncatingTail
        movieOverview.numberOfLines   = 3
        movieOverview.font            = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    
    func configureSymbolImageView() {
        backView.addSubview(symbolImageView)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor   = .secondaryLabel
        symbolImageView.image       = SFSymbols.calendar
    }
    
    
    func configureDateLabel() {
        backView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor   = .secondaryLabel
        dateLabel.font        = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    
    let innerPadding: CGFloat = 10
    let outerPadding: CGFloat = 4
    
    func configureElements() {
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: backView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 110),
            
            movieTitleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: outerPadding),
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
            
            dateLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: innerPadding),
            dateLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -innerPadding),
            dateLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
}
