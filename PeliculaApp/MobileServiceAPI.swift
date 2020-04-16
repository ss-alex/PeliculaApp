//
//  NetworkManager.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/13.
//  Copyright © 2020 Surf. All rights reserved.
//


import Foundation

class MobileServiceAPI {
    
    enum Endpoint: String, CaseIterable {
        
        case nowPlaying = "now_playing"
        case upcoming = "upcoming"
        case popular = "popular"
        case topRated = "top_rated"
    }
    
    
    public enum APIServiceError: Error {
        
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    public static let shared = MobileServiceAPI()
    
    private init() {}
    
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "7dbb4be29f1194262f58b011ed0f0a8c"
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    
    
    private func fetchMovieInfo <T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (result) in
            switch result {
                
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                completion(.failure(.apiError))
            }
        }.resume()
    }
    

    public func fetchMovies(from endpoint: Endpoint, result: @escaping (Result<MoviesResponse, APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent(endpoint.rawValue)
        
        fetchMovieInfo(url: movieURL, completion: result)
    }
    
    
    
    public func fetchMovie(movieID: Int, result: @escaping (Result <Movie, APIServiceError>) -> Void) {
        
        let movieURL = baseURL
        .appendingPathComponent("movie")
        .appendingPathComponent(String(movieID))
        
        fetchMovieInfo(url: movieURL, completion: result)
    }
    
    
    
    
    
    
    public func searchMovie(query: String, params: [String : String]?, completion: @escaping (Result<MoviesResponse,APIServiceError>) -> Void) {
        
        guard var urlComponents = URLComponents(string: "\(baseURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "language", value: "en-US"),
        URLQueryItem(name: "include_adult", value: "false"),
        URLQueryItem(name: "region", value: "US"),
        URLQueryItem(name: "query", value: query)
        ]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (result) in
            switch result {
                
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                completion(.failure(.apiError))
            }
        }.resume()
    }
}
