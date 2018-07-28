//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Liza Liutova on 7/28/18.
//  Copyright © 2018 Liza Liutova. All rights reserved.
//

import UIKit
import AlamofireImage

class SuperheroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies : [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellsPerLine: CGFloat = 2
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        fetchMovies()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterPath = movie["poster_path"] as? String{
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let actualURL = URL(string: baseURL + posterPath)!
            cell.posterImageView.af_setImage(withURL: actualURL)
        }
        return cell
    }
    
    func fetchMovies (){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //this will run when network request returns
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                let dataDictionary = try!  JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //                print(dataDictionary)
                let movies = dataDictionary["results"] as! [[String:Any]]
                self.movies = movies
                self.collectionView.reloadData()
//                self.refreshControl.endRefreshing()
//                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
