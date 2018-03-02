//
//  MovieAPIManager.swift
//  flix
//
//  Created by Sandra Luo on 3/1/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import Foundation

class MovieAPIManager {
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let apiKeyString = "now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func nowPlayingMovies(completion: @escaping([Movie]?, Error?) -> ()) {
        let url = URL(string: MovieAPIManager.baseURL + MovieAPIManager.apiKeyString)
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.movies(dictionaries: movieDictionaries)
                completion(movies, nil)
            }
            else {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
