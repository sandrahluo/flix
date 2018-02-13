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
    var movie: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            
            titleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie[MovieKeys.releaseDatePath] as? String
            overviewLabel.text = movie[MovieKeys.overviewPath] as? String
            let backDropPathString = movie[MovieKeys.backDropPath] as! String
            let posterPathString = movie[MovieKeys.posterPath] as! String
            
            let backDropURL = URL(string: MovieKeys.baseURLString + backDropPathString)!
            backdropImageView.af_setImage(withURL: backDropURL)
            
            let posterPathURL = URL(string: MovieKeys.baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
