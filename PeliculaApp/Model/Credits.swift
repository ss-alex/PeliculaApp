//
//  Credits.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/27.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation


struct Credits: Codable {
    let cast: [Cast]?
}


struct Cast: Codable {
    let name: String?
    let profilePath: String?
    public var profileURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
    }
}
