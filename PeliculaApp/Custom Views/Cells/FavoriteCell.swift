//
//  FavoriteCell.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/23.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    
    let posterImage = PAPosterImageView(frame: .zero)
    let movieTitle  = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMovieTitle()
        configurePosterImage()
        configureLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configurePosterImage() {
        self.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.backgroundColor = .systemGray4
        
        posterImage.image = UIImage(named: "placeholder3")
        posterImage.contentMode = .scaleAspectFit
    }
    
    
    func configureMovieTitle() {
        self.addSubview(movieTitle)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        
        movieTitle.textAlignment = .left
        movieTitle.font          = UIFont.systemFont(ofSize: 20, weight: .bold)
        movieTitle.textColor     = .label
        movieTitle.lineBreakMode = .byTruncatingTail
        movieTitle.adjustsFontSizeToFitWidth = false
        
        movieTitle.numberOfLines = 2
    }
    
    
    private func configureLayout() {
        accessoryType       = .disclosureIndicator
        
        let padding:CGFloat = 12
        
        NSLayoutConstraint.activate([
            posterImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            posterImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            posterImage.heightAnchor.constraint(equalToConstant: 120),
            posterImage.widthAnchor.constraint(equalToConstant: 80),
            
            movieTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 24),
            movieTitle.widthAnchor.constraint(equalToConstant: 200),
            movieTitle.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func setTextAndImageFor(favorite: FavoritedMovie) {
        posterImage.downloadPosterImage(fromURL: favorite.posterURL)
        movieTitle.text = favorite.title
    }
    
}
