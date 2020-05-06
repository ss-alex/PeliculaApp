//
//  MovieCategory.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/5/2.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

enum MovieCategory: String {
    case popular    = "popular"
    case nowPlaying = "now_playing"
    case topRated   = "top_rated"
}


extension MovieCategory {
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .nowPlaying:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        }
    }
}
