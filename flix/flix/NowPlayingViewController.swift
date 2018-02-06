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
    var movies:[[String:Any]] = []
    // want refreshControl to be accessible by multiple functions
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.stopAnimating()
        
        //functionality to detect pulling to refresh
        refreshControl = UIRefreshControl()
        //when valueChanged trigger goes off, will notify self to perform didPullToRefresh and pass itself in as parameter
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        // "self" = NowPlayingViewController
        tableView.dataSource = self
        self.tableView.rowHeight = 200
        fetchMovies()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {

        fetchMovies()
    }
    
    func fetchMovies() {
        //url for the endpoint
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        //cache policy: our network will always reload from the network even if there is data in cache, for testing purposes
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //when our network request returns, it will jump back on our main thread
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //this will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                //String keys and values can be anything
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                //update the UI now that we've got info back from network request
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
    }
    
    // indicate how many cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // tell tableView what the cells are going to be
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //casting UITableViewCell as MovieCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        //indexpath is called everytime we make a new cell; get info from json
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
