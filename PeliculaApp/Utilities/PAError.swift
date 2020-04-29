//
//  PAError.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/21.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation


enum PAError: String, Error {
    
    case apiError             = "Unable to complete your request. Plese check your internet"
    case invalidEndpoint      = "This endpoint created an invalid request."
    case invalidResponse      = "Invalid response from the server."
    case decodeError          = "There is an error while decoding."
    
    case invalidMovieKeyword  = "This movie keyword created an invalid request. Please try again."
    case unableToFavorite     = "There was an error favoriting this movie. Please try it again."
    case alreadyInFavorites   = "You've already favorited this movie."
}
