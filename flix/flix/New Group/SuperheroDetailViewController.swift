//
//  SuperheroDetailViewController.swift
//  flix
//
//  Created by Sandra Luo on 2/12/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import UIKit
enum keys {
    static let title = "title"
    static let backDropPath = "backdrop_path"
    static let posterPath = "poster_path"
    static let releaseDatePath = "release_date"
    static let overviewPath = "overview"
    static let baseURLString = "https://image.tmdb.org/t/p/w500"
}
class SuperheroDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            
            titleLabel.text = movie[keys.title] as? String
            releaseDateLabel.text = movie[keys.releaseDatePath] as? String
            overviewLabel.text = movie[keys.overviewPath] as? String
            let backDropPathString = movie[keys.backDropPath] as! String
            let posterPathString = movie[keys.posterPath] as! String
            
            let backDropURL = URL(string: keys.baseURLString + backDropPathString)!
            backdropImageView.af_setImage(withURL: backDropURL)
            
            let posterPathURL = URL(string: keys.baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
