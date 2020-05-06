//
//  FavoritedMovie.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/21.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

struct FavoritedMovie: Codable, Hashable {
    let id: Int
    let title: String
    let posterPath: String?
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}
