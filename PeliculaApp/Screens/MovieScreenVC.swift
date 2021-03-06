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
    let castLabel           = UILabel()
    
    let outerPadding: CGFloat = 20
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    var movies: [Movie] = []
    var movieID:Int!
    
    var collectionView: UICollectionView!
    var casts: [Cast] = []
    
    let scrollView   = UIScrollView()
    let contentView  = UIView()
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
    super.viewDidLoad()
    self.view = view
        fetchMovieByID()
        fetchCreditsByMovieID()
        configureViewController()
        configureScrollView()
        configureBackdropImageView()
        configurePosterImageView()
        configureScoreLabel()
        configureMovieLabel()
        configureGenreLabel()
        configureTimeLabel()
        configureReleaseLabel()
        configureIntroLabel()
        configureOverviewLabel()
        configureCastLabel()
        configureCollectionView()
       
        configureLayout()
    }
    
    //MARK:- General Methods
    
    override func viewWillAppear(_ animated: Bool) {
        movies.removeAll()
        casts.removeAll()
    }
    
    
    func configureViewController() {
        view.backgroundColor = PAColors.customGrayBackground.color
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissUserInfoVC))
        navigationItem.leftBarButtonItem = doneButton
        navigationItem.leftBarButtonItem?.tintColor = PAColors.customRed.color
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = PAColors.customRed.color
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.pin(to: view)
        scrollView.addSubview(contentView)
        contentView.pin(to: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 750)
        ])
    }
    
    
    func fetchMovieByID() {
        self.showLoadingView(onView: self.view)
        
        NetworkManager.shared.fetchMovie(movieID: movieID) { (result: Result<Movie, PAError>) in
            
            switch result {
            case . success(let movie):
                print(movie)
                
                DispatchQueue.main.async {
                    NetworkManager.shared.downloadImage(url: movie.backdropURL) { image in
                        self.backdropImageView.image = image
                    }
                    
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
                    
                    let attributedString       = NSMutableAttributedString(string: movie.overview)
                    let paragraphStyle         = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 11
                    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
                    self.overviewLabel.attributedText = attributedString
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.removeLoadingView()
        }
    }
    
    
    func fetchCreditsByMovieID() {
        NetworkManager.shared.fetchCredits(movieID: movieID) { (result: Result<Credits, PAError>) in
            
            switch result {
            case . success(let cast):
                print(cast)
                let castsInfo = cast.cast!
                self.casts.append(contentsOf: castsInfo)
                
                DispatchQueue.main.async { self.collectionView.reloadData() }
                    
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func configureBackdropImageView() {
        contentView.addSubview(backdropImageView)
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.backgroundColor   = .systemGray2
        backdropImageView.image             = Images.backdropPlaceholder
        backdropImageView.contentMode       = .scaleAspectFit
    }
       
       
    func configurePosterImageView() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.backgroundColor = .systemGray3
           
        posterImageView.layer.cornerRadius   = 10
        posterImageView.layer.borderWidth    = 2
        posterImageView.layer.borderColor    = UIColor.white.cgColor
        posterImageView.clipsToBounds        = true
    }
       
       
    func configureScoreLabel() {
        contentView.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.backgroundColor = PAColors.customRed.color
        
        scoreLabel.layer.cornerRadius   = 40/2
        scoreLabel.clipsToBounds        = true
        scoreLabel.textAlignment        = .center
        scoreLabel.font                 = UIFont.systemFont(ofSize: 18, weight: .bold)
        scoreLabel.textColor            = .systemBackground
           
    }
       
       
    func configureMovieLabel() {
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        movieTitleLabel.adjustsFontSizeToFitWidth   = true
        movieTitleLabel.minimumScaleFactor          = 0.9
        movieTitleLabel.font                        = UIFont.preferredFont(forTextStyle: .headline)
        movieTitleLabel.textColor                   = .darkGray
        movieTitleLabel.lineBreakMode               = .byTruncatingTail
        movieIntroLabel.numberOfLines               = 1
    }
       
       
    func configureGenreLabel() {
        contentView.addSubview(genreLabel)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.textColor   = .darkGray
        genreLabel.font        = UIFont.preferredFont(forTextStyle: .caption1)
    }
       
       
    func configureTimeLabel() {
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor   = .darkGray
        timeLabel.font        = UIFont.preferredFont(forTextStyle: .caption1)
    }
       
       
    func configureReleaseLabel() {
        contentView.addSubview(releaseLabel)
        releaseLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseLabel.textColor   = .darkGray
        releaseLabel.font        = UIFont.preferredFont(forTextStyle: .caption1)
    }
       
       
    func configureIntroLabel() {
        contentView.addSubview(movieIntroLabel)
        movieIntroLabel.translatesAutoresizingMaskIntoConstraints = false
        movieIntroLabel.text        = "Overview"
        movieIntroLabel.font        = UIFont.preferredFont(forTextStyle: .headline)
        movieIntroLabel.textColor   = .darkGray
    }
       
       
    func configureOverviewLabel() {
        contentView.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font            = UIFont.systemFont(ofSize: 14, weight: .regular)
        overviewLabel.lineBreakMode   = .byTruncatingTail
        overviewLabel.numberOfLines   = 7
        overviewLabel.textColor       = .darkGray
    }
    
    
    func configureCastLabel() {
        contentView.addSubview(castLabel)
        castLabel.translatesAutoresizingMaskIntoConstraints = false

        castLabel.text        = "Cast"
        castLabel.font        = UIFont.preferredFont(forTextStyle: .headline)
        castLabel.textColor   = .darkGray
    }
    

    func configureCollectionView() {
        
        let flowLayout               = PACarouselFlowLayout()
        flowLayout.scrollDirection   = .horizontal
        flowLayout.sideItemScale     = 0.9
        flowLayout.sideItemAlpha     = 1
        flowLayout.spacingMode       = .overlap(visibleOffset: 40)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate     = self
        collectionView.dataSource   = self
        collectionView.register(CastCustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    
    
    func configureLayout() {
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 230),
               
            posterImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 164),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outerPadding),
            posterImageView.widthAnchor.constraint(equalToConstant: 110),
            posterImageView.heightAnchor.constraint(equalToConstant: 160),
               
            scoreLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 210),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerPadding),
            scoreLabel.widthAnchor.constraint(equalToConstant: 40),
            scoreLabel.heightAnchor.constraint(equalToConstant: 40),
               
            movieTitleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 8),
            movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            movieTitleLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -8),
               
            genreLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerPadding),
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
            movieIntroLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outerPadding),
            movieIntroLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerPadding),
            movieIntroLabel.heightAnchor.constraint(equalToConstant: 20),
               
            overviewLabel.topAnchor.constraint(equalTo: movieIntroLabel.bottomAnchor, constant: 12),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outerPadding),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerPadding),
            
            castLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 26),
            castLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outerPadding),
            castLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerPadding),
            castLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 128)
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


//MARK:- Extensions
extension MovieScreenVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
        //return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CastCustomCell
        
        let cast = casts[indexPath.row]
        cell.setTextAndImageFor(cast: cast)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4.5, height: collectionView.frame.width/4)
    }
    
}

