//
//  MovieScreenVCViewController.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/20.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class MovieScreenVC: UIViewController {

    let backdropImageView   = UIImageView()
    let posterImageView     = UILabel()
    let scoreLabel          = UILabel()
    let movieTitleLabel     = UILabel()
    let genreLabel          = UILabel()
    let timeLabel           = UILabel()
    let releaseLabel        = UILabel()
    let movieIntroLabel     = UILabel()
    let overviewLabel       = UILabel()
    let castLabel           = UILabel()
    
    let outerPadding: CGFloat = 20
    
    /*fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        func configureBackdropImageView() {
               view.addSubview(backdropImageView)
               backdropImageView.translatesAutoresizingMaskIntoConstraints = false
               backdropImageView.backgroundColor = .yellow
           }
           
           
           func configurePosterImageView() {
               view.addSubview(posterImageView)
               posterImageView.translatesAutoresizingMaskIntoConstraints = false
               posterImageView.backgroundColor = .systemGray2
               
               posterImageView.layer.cornerRadius = 10
               posterImageView.clipsToBounds = true
           }
           
           
           func configureScoreLabel() {
               view.addSubview(scoreLabel)
               scoreLabel.translatesAutoresizingMaskIntoConstraints = false
               scoreLabel.backgroundColor = .systemBlue
               scoreLabel.layer.cornerRadius = 40/2
               scoreLabel.clipsToBounds = true
               
               scoreLabel.text = "9.6"
               scoreLabel.textAlignment = .center
               scoreLabel.font          = UIFont.systemFont(ofSize: 18, weight: .bold)
               scoreLabel.textColor     = .systemBackground
               
           }
           
           
           func configureMovieLabel() {
               view.addSubview(movieTitleLabel)
               movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
               //movieTitleLabel.backgroundColor            = .systemGray4
               movieTitleLabel.text                       = "Avatar the reunion"
               movieTitleLabel.adjustsFontSizeToFitWidth  = true
               movieTitleLabel.minimumScaleFactor         = 0.9
               movieTitleLabel.font                       = UIFont.preferredFont(forTextStyle: .headline)
               movieTitleLabel.textColor                  = .darkGray
               movieTitleLabel.lineBreakMode              = .byTruncatingTail
               movieIntroLabel.numberOfLines              = 1
           }
           
           
           func configureGenreLabel() {
               view.addSubview(genreLabel)
               genreLabel.translatesAutoresizingMaskIntoConstraints = false
               //genreLabel.backgroundColor = .systemGray5
               genreLabel.text            = "Action, Thriller"
               genreLabel.font            = UIFont.preferredFont(forTextStyle: .caption1)
               genreLabel.textColor       = .systemGray
           }
           
           
           func configureTimeLabel() {
               view.addSubview(timeLabel)
               timeLabel.translatesAutoresizingMaskIntoConstraints = false
               //timeLabel.backgroundColor = .systemGray5
               timeLabel.text            = "Length of a film:"
               timeLabel.font            = UIFont.preferredFont(forTextStyle: .caption1)
               timeLabel.textColor       = .systemGray
           }
           
           
           func configureReleaseLabel() {
               view.addSubview(releaseLabel)
               releaseLabel.translatesAutoresizingMaskIntoConstraints = false
               //releaseLabel.backgroundColor = .systemGray5
               releaseLabel.text            = "Release time: Nov 22, 2017"
               releaseLabel.font            = UIFont.preferredFont(forTextStyle: .caption1)
               releaseLabel.textColor       = .systemGray
           }
           
           
           func configureIntroLabel() {
               view.addSubview(movieIntroLabel)
               movieIntroLabel.translatesAutoresizingMaskIntoConstraints = false
               //movieIntroLabel.backgroundColor = .systemGray5
               movieIntroLabel.text            = "Overview"
               movieIntroLabel.font            = UIFont.preferredFont(forTextStyle: .headline)
               movieIntroLabel.textColor       = .darkGray
           }
           
           
           func configureOverviewLabel() {
               view.addSubview(overviewLabel)
               overviewLabel.translatesAutoresizingMaskIntoConstraints = false
               //overviewLabel.backgroundColor   = .systemGray5
               
               overviewLabel.font              = UIFont.systemFont(ofSize: 14, weight: .regular)
               overviewLabel.lineBreakMode     = .byTruncatingTail
               overviewLabel.numberOfLines     = 4
               overviewLabel.textColor         = .systemGray2
           
               // making spacing in UILabel Programatically ->
               let textString = "Aieuriujdkjflkajdsf klajfk jioeru j`fkx iejf kljfkj oiurei kladsfjl;kasdjflkjasf eoursfdjkljalks;f akdsfjkjajfdlkj ajkajfklsdj fkljfewj kjfkljdfksj eiwjf lkdsfj lkjewfj kldfjf kjk ekj flkjvdslkjf lk kjdsf  klejf kljf slkdjflkjdskfj lkwejf kljfkl jkjfsd jklfdslk jkldjflk jlksdj f"
               let stringStyle = NSMutableParagraphStyle()
               stringStyle.lineSpacing = 11
               let attrString = NSMutableAttributedString(string: textString)
               attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: stringStyle, range: NSMakeRange(0, attrString.length))
               overviewLabel.attributedText = attrString
           }
           
        
            func configureCastLabel() {
                view.addSubview(castLabel)
                castLabel.translatesAutoresizingMaskIntoConstraints = false
                castLabel.text       = "Cast"
                castLabel.font       = UIFont.preferredFont(forTextStyle: .headline)
                castLabel.textColor  = .darkGray
            }
        
            
        /*func configureCollectionView() {
            view.addSubview(collectionView)
            collectionView.backgroundColor = .yellow
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }*/
           
        
           func configureLayout() {
               NSLayoutConstraint.activate([
                   backdropImageView.topAnchor.constraint(equalTo: view.topAnchor),
                   backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   backdropImageView.heightAnchor.constraint(equalToConstant: 240),
                   
                   posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 174),
                   posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
                   posterImageView.widthAnchor.constraint(equalToConstant: 110),
                   posterImageView.heightAnchor.constraint(equalToConstant: 160),
                   
                   scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
                   scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
                   scoreLabel.widthAnchor.constraint(equalToConstant: 40),
                   scoreLabel.heightAnchor.constraint(equalToConstant: 40),
                   
                   movieTitleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 8),
                   movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
                   movieTitleLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -8),
                   //movieTitleLabel.heightAnchor.constraint(equalToConstant: 24),
                   
                   genreLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
                   genreLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
                   genreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
                   genreLabel.heightAnchor.constraint(equalToConstant: 18),
                   
                   timeLabel.bottomAnchor.constraint(equalTo: genreLabel.topAnchor, constant: -2),
                   timeLabel.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
                   timeLabel.trailingAnchor.constraint(equalTo: genreLabel.trailingAnchor),
                   timeLabel.heightAnchor.constraint(equalToConstant: 18),
                   
                   releaseLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -2),
                   releaseLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
                   releaseLabel.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
                   releaseLabel.heightAnchor.constraint(equalToConstant: 18),
                   
                   movieIntroLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 26),
                   movieIntroLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
                   movieIntroLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
                   movieIntroLabel.heightAnchor.constraint(equalToConstant: 20),
                   
                   overviewLabel.topAnchor.constraint(equalTo: movieIntroLabel.bottomAnchor, constant: 12),
                   overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
                   overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
                   
                   castLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 26),
                   castLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
                   castLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
                   castLabel.heightAnchor.constraint(equalToConstant: 20)
                   
                   /*collectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 12),
                   collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
                   collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
                   collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5)*/
               ])
           }
    }
    
}


/*extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemPink
        return cell
    }
}*/
