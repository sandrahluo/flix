//
//  Movie.swift
//  flix
//
//  Created by Sandra Luo on 3/1/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import Foundation

class Movie {
    // add properties for data to access from the API + determine whether they are optionals
    var title: String
    var releaseDate: String
    var posterURL: URL?
    var overview: String
    var backdropURL: URL?
    
    // must create initializers that sets non-optional properties
    init(dictionary: [String:Any]) {
        // retrieve data from online database
        // ?? will use "No title" if the casting of title fails
        title = dictionary["title"] as? String ?? "No title"
        releaseDate = dictionary["release_date"] as? String ?? "No release date available"
        overview = dictionary["overview"] as? String ?? "No overview available"

        let backdropPathString = dictionary["backdrop_path"] as! String
        let posterPathString = dictionary["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        backdropURL = URL(string: baseURLString + backdropPathString)!
        posterURL = URL(string: baseURLString + posterPathString)!
    }

    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
}
