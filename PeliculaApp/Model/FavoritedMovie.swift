//
//  FavoritedMovie.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/21.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public struct FavoritedMovie: Codable, Hashable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}
