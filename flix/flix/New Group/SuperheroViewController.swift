//
//  SuperheroViewController.swift
//  flix
//
//  Created by Sandra Luo on 2/12/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies:[[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        // collectionView flow layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellsPerLine:CGFloat = 2
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        
        // subtract 1 since last cell doesn't have spacing after it
        // interitem = between cells (horizontally)
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        // 2:3 ratio between width and height
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        fetchMovies()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cast as posterCell so that we can set the poster property
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            // force unwrapping this since we know the posterPathString will not be nil
            let posterURL = URL(string: baseURLString + posterPathString)!
            cell.PosterImageView.af_setImage(withURL: posterURL)
        }
        return cell
    }
    
    func fetchMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.collectionView.reloadData()
                //self.refreshControl.endRefreshing()
            }
        }
        task.resume()
    }
    
    // segues define a transition between two ViewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // starting point of segue is what initiates the segue
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            // end point of segue is the viewController we want to move to
            let detailViewController = segue.destination as! SuperheroDetailViewController
            detailViewController.movie = movie
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
