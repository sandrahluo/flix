//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Sandra Luo on 2/5/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    // array of dictionaries initialized as empty
    var movies:[Movie] = []
    // want refreshControl to be accessible by multiple functions
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        //functionality to detect pulling to refresh
        refreshControl = UIRefreshControl()
        //when valueChanged trigger goes off, will notify self to perform didPullToRefresh and pass itself in as parameter
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        // "self" = NowPlayingViewController
        tableView.dataSource = self
        self.tableView.rowHeight = 200
        fetchMovies()
        activityIndicator.stopAnimating()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    
    func fetchMovies() {
        MovieAPIManager().nowPlayingMovies{ (movies: [Movie]?, error: Error?) in
            if let movies = movies {
            self.movies = movies
                //update the UI now that we've got info back from network request
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // indicate how many cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // tell tableView what the cells are going to be
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //casting UITableViewCell as MovieCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    // gets called everytime a segue from a viewController gets initiated
    // sender is the segue initiator
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // cell that was selected initiates the segue
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            // indexPath has index and row
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
