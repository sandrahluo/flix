//
//  MovieCell.swift
//  flix
//
//  Created by Sandra Luo on 2/5/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    // create a property observer that makes the MovieCell responsible for configuring its own view; monitors changes to property's values
    var movie: Movie! {
        // called immediately after the new value is stored (vs willSet)
        didSet {
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            
            if movie.posterURL != nil {
                posterImageView.af_setImage(withURL: movie.posterURL!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
