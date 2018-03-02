//
//  DetailViewController.swift
//  flix
//
//  Created by Sandra Luo on 2/6/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import UIKit
enum MovieKeys {
    static let title = "title"
    static let backDropPath = "backdrop_path"
    static let posterPath = "poster_path"
    static let releaseDatePath = "release_date"
    static let overviewPath = "overview"
    static let baseURLString = "https://image.tmdb.org/t/p/w500"
}
class DetailViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    // question mark denotes "optional" in case there isn't a movie
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            if movie.posterURL != nil {
                backdropImageView.af_setImage(withURL: movie.backdropURL!)
            }
            if movie.posterURL != nil {
                posterImageView.af_setImage(withURL: movie.posterURL!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
