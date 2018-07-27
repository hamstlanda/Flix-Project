//
//  DetailViewController.swift
//  Flix
//
//  Created by Liza Liutova on 7/27/18.
//  Copyright © 2018 Liza Liutova. All rights reserved.
//

import UIKit
import AlamofireImage

enum MovieKeys {
    static let title = "title"
    static let release = "release_date"
    static let description = "overview"
    static let backdrop = "backdrop_path"
    static let poster = "poster_path"
}
class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie : [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie[MovieKeys.release] as? String
            descriptionLabel.text = movie[MovieKeys.description] as? String
            let backdroppathstring = movie[MovieKeys.backdrop] as! String
            let posterpath = movie[MovieKeys.poster] as! String
            let baseURL = "https://image.tmdb.org/t/p/w200"
            
            let backdropURL = URL(string: baseURL + backdroppathstring )!
            let posterURL = URL(string: baseURL + posterpath)!
            backdropImageView.af_setImage(withURL: backdropURL)
            posterImageView.af_setImage(withURL: posterURL)
        }
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
