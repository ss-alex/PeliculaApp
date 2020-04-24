//
//  PAPosterImageView.swift
//  PeliculaApp
//
//  Created by Лена Мырленко on 2020/4/23.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PAPosterImageView: UIImageView {

    let cache = NetworkManager.shared.imageCache
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
    }
    
    
    func downloadPosterImage(fromURL url: URL) {
        NetworkManager.shared.downloadImage(url: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

}
