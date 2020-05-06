//
//  Movie.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/13.
//  Copyright © 2020 Surf. All rights reserved.
//


import Foundation

struct MoviesResponse: Codable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
}


struct Movie: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let releaseDate: Date
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let runtime: Int?
    let genres: [MovieGenre]?
    let backdropPath: String?
    let posterPath: String?
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
}


struct MovieGenre: Codable {
    let name: String
}






