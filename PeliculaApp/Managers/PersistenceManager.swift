//
//  PersistenceManager.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/21.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation


enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys {
        //static let favouritesKey = "favorites"
        static let favouritesKey2 = "favorites2"
    }
    
    static func updateWith(favoritedMovie: FavoritedMovie, actionType: PersistenceActionType, completed: @escaping (PAError?) -> Void) {
        
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favoritedMovie) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favoritedMovie)
                    
                case .remove:
                    favorites.removeAll {$0.title == favoritedMovie.title}
                }
                
                completed(save(favoritedMovies: favorites))
                
            case .failure(let error):
                completed(error)
                print ("error inside retrieveFavorites method")
            }
        }
    }
    
    
    //Get data of already favorited movies.. First Decoding then Encoding
    static func retrieveFavorites(completed: @escaping (Result<[FavoritedMovie], PAError>) -> Void) {
        
        guard let favoritesData = defaults.object(forKey: Keys.favouritesKey2) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FavoritedMovie].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
            print("unableToFavorite. error - inside do+catch retrieveFavorites")
        }
    }
    

    //Save new movie to the array of favorited movies. Encoding.
    static func save(favoritedMovies: [FavoritedMovie]) -> PAError? { /// if saving is successful, we gonna return 'nil'
        
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favoritedMovies)
            defaults.set(encodedFavorites, forKey: Keys.favouritesKey2)
            return nil /// we are returning 'nil' because no error happens
        } catch {
            return .unableToFavorite
            print ("unableToFavorite error in save method")
        }
    }
    
}
