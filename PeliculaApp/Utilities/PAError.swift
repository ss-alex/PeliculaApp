//
//  PAError.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/21.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

enum PAError: String, Error {
    case invalidMovieKeyword    = "This movie keyword created an invalid request. Please try again."
    //case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    //case invalidResponse        = "Invalid response from the server. Please try again."
    //case invalidData            = "The data received from the server was invalid. Please try again."
    case unableToFavorite      = "There was an error favoriting this movie. Please try it again."
    case alreadyInFavorites    = "You've already favorited this movie."
}
