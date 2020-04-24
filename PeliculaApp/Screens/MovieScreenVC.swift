//
//  MovieScreenVCViewController.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/20.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class MovieScreenVC: UIViewController {

    //MARK:- Properties
    
    let backdropImageView   = UIImageView()
    let posterImageView     = UIImageView()
    let scoreLabel          = UILabel()
    let movieTitleLabel     = UILabel()
    let genreLabel          = UILabel()
    let timeLabel           = UILabel()
    let releaseLabel        = UILabel()
    let movieIntroLabel     = UILabel()
    let overviewLabel       = UILabel()
    
    let outerPadding: CGFloat = 20
    
    var movies: [Movie] = []
    var movieID:Int!
  
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
    super.viewDidLoad()
    self.view = view
        configureViewController()
        configureBackdropImageView()
        configurePosterImageView()
        configureScoreLabel()
        configureMovieLabel()
        configureGenreLabel()
        configureTimeLabel()
        configureReleaseLabel()
        configureIntroLabel()
        configureOverviewLabel()
       
        configureLayout()
        fetchMovieByID()
        
        checkMovieID()
    }
    
    //MARK:- Methods
    
    func checkMovieID() {
        dump(movieID)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissUserInfoVC))
        navigationItem.leftBarButtonItem = doneButton
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()

    func fetchMovieByID() {
        
        movies.removeAll()
        
        NetworkManager.shared.fetchMovie(movieID: movieID) { (result: Result<Movie, NetworkManager.APIServiceError>) in
            
            switch result {
            case . success(let movie):
                print(movie)
                
                DispatchQueue.main.async {
                    //self.backdropImageView.load(url: movie.backdropURL)
                    NetworkManager.shared.downloadImage(url: movie.backdropURL) { image in
                        self.backdropImageView.image = image
                    }
                    //self.posterImageView.load(url: movie.posterURL)
                    NetworkManager.shared.downloadImage(url: movie.posterURL) { image in
                        self.posterImageView.image = image
                    }
                    self.movieTitleLabel.text = movie.title
                    self.scoreLabel.text      = String(movie.voteAverage)
                    self.releaseLabel.text    = "Release time: \(MovieScreenVC.dateFormatter.string(from: movie.releaseDate))"
                    self.timeLabel.text       = "Length of a film: \(movie.runtime ?? 0) min"
                    if let genres = movie.genres, genres.count > 0 {
                        self.genreLabel.text = genres.map { $0.name }.joined(separator: ", ")
                    } else {
                        self.genreLabel.text = "N/A"
                    }
                    
                    ///making spacing in UILabel Programatically ->
                    let attributedString       = NSMutableAttributedString(string: movie.overview)
                    let paragraphStyle         = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 11
                    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
                    self.overviewLabel.attributedText = attributedString
                    
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func configureBackdropImageView() {
        view.addSubview(backdropImageView)
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.backgroundColor = .systemGray2
    }
       
       
    func configurePosterImageView() {
        view.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.backgroundColor = .systemGray2
           
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.borderColor = UIColor.white.cgColor
        posterImageView.clipsToBounds = true
    }
       
       
    func configureScoreLabel() {
        view.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.backgroundColor = .systemBlue
        scoreLabel.layer.cornerRadius = 40/2
        scoreLabel.clipsToBounds = true
        
        scoreLabel.textAlignment = .center
        scoreLabel.font          = UIFont.systemFont(ofSize: 18, weight: .bold)
        scoreLabel.textColor     = .systemBackground
           
    }
       
       
    func configureMovieLabel() {
        view.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
           //movieTitleLabel.backgroundColor            = .systemGray4
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
        genreLabel.font            = UIFont.preferredFont(forTextStyle: .caption1)
        genreLabel.textColor       = .systemGray
    }
       
       
    func configureTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        //timeLabel.backgroundColor = .systemGray5
        timeLabel.font            = UIFont.preferredFont(forTextStyle: .caption1)
        timeLabel.textColor       = .systemGray
    }
       
       
    func configureReleaseLabel() {
        view.addSubview(releaseLabel)
        releaseLabel.translatesAutoresizingMaskIntoConstraints = false
        //releaseLabel.backgroundColor = .systemGray5
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
        overviewLabel.numberOfLines     = 5
        overviewLabel.textColor         = .systemGray2
    }
    
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 240),
               
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 174),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
            posterImageView.widthAnchor.constraint(equalToConstant: 110),
            posterImageView.heightAnchor.constraint(equalToConstant: 160),
               
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 220),
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
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding)
        ])
    }
    
    
    //MARK:- @objc Methods
    
    @objc func dismissUserInfoVC () { dismiss(animated: true) }
    
    
    @objc func addButtonTapped() {
        
        NetworkManager.shared.fetchMovie(movieID: movieID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let movie):
                    dump(movie)
                    self.addMovieToFavorites(with: movie)
                
            case .failure(let error):
                self.presentPAAlertOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
    
    
    func addMovieToFavorites(with movie: Movie) {
        
        let favoritedMovie = FavoritedMovie(id: movie.id, title: movie.title, posterPath: movie.posterPath)
        dump(favoritedMovie)

        PersistenceManager.updateWith(favoritedMovie: favoritedMovie, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.presentPAAlertOnMainThread(title: "Success!", message: "You have successfully favorited this movie.", buttonTitle: "Hooray!")
                return
            }
            
            self.presentPAAlertOnMainThread(title: "Something went wrong", message: "The movie has been already favorited." , buttonTitle: "Ok")
            print("error inside updteWith")
        }
    }
    
}
