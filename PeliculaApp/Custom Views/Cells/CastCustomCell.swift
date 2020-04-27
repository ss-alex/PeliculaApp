//
//  CastCustomCell.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/27.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class CastCustomCell: UICollectionViewCell {
    
    let castImageView   = UIImageView()
    let castNameLabel   = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCastImageView()
        configureCastNameLabel()
        configureLayout()
        //self.backgroundColor = .purple
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    func setTextAndImageFor(cast: Cast) {
        NetworkManager.shared.downloadImage(url: cast.profileURL) { (image) in
            self.castImageView.image = image
        }
        self.castNameLabel.text = cast.name
    }
    
    
    func configureCastImageView() {
        self.addSubview(castImageView)
        castImageView.translatesAutoresizingMaskIntoConstraints = false
        
        castImageView.layer.borderColor  = UIColor.label.cgColor
        castImageView.layer.borderWidth  = 2
        castImageView.layer.cornerRadius = 60/2
        castImageView.clipsToBounds      = true
        castImageView.contentMode        = .scaleAspectFill
    }
    
    
    func configureCastNameLabel() {
        self.addSubview(castNameLabel)
        castNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        castNameLabel.textAlignment     = .center
        castNameLabel.numberOfLines     = 2
        castNameLabel.lineBreakMode     = .byTruncatingTail
        castNameLabel.font              = UIFont.preferredFont(forTextStyle: .caption1)
        castNameLabel.textColor         = .systemGray
    }
    
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            castImageView.widthAnchor.constraint(equalToConstant: 60),
            castImageView.heightAnchor.constraint(equalToConstant: 60),
            
            castNameLabel.topAnchor.constraint(equalTo: castImageView.bottomAnchor),
            castNameLabel.leadingAnchor.constraint(equalTo: castImageView.leadingAnchor),
            castNameLabel.trailingAnchor.constraint(equalTo: castImageView.trailingAnchor),
            castNameLabel.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    
}
