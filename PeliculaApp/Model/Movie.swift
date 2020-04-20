//
//  Movie.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/13.
//  Copyright © 2020 Surf. All rights reserved.
//


import Foundation

public struct MoviesResponse: Codable {
    
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}


public struct Movie: Codable {
    
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: Date
    public let voteAverage: Double
    public let voteCount: Int
    public let adult: Bool
    public let runtime: Int?
    public let genres: [MovieGenre]?
    public let backdropPath: String?
    public let posterPath: String?
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
}


public struct MovieGenre: Codable {
    let name: String
}
