//
//  DiscoverView.swift
//  WilsonWang-Lab4
//
//  Created by Wilson Wang on 10/30/23.
//

import UIKit

class DiscoverView: UIViewController {

    var theCurrentRec: Movie? {
        didSet{
            updateView()
        }
    }
    let favlist = FavList()
    
    @IBAction func likeMovie(_ sender: UIButton) {
        sender.setImage(UIImage(named: "like"), for: UIControl.State.normal)
        
        // add to fav
        favlist.add(title: theCurrentRec!.title)
    }
    
    @IBOutlet weak var movieView: UIView!
    
    @IBOutlet weak var likeMovieButton: UIButton!
    
    @IBAction func nextMovie(_ sender: UIButton) {
        fetchRandom()
        likeMovieButton.setImage(UIImage(named: "beforelike"), for: UIControl.State.normal)
    }
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchRandom()
        movieView.sendSubviewToBack(poster)
    }
    

   
    func fetchRandom() {
        let page = Int.random(in: 1 ..< 200)
        let index = Int.random(in: 1 ..< 20)
        
        let url = URL(string:"https://api.themoviedb.org/3/discover/movie?api_key=f37970f052856742371d3453baf5bf09&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)")
        
        let data = try! Data(contentsOf: url!)
        let result = try! JSONDecoder().decode(APIResults.self, from: data).results
        
        theCurrentRec = result[index]
    }
    
    func updateView(){
        movieTitle.text = theCurrentRec!.title
        movieDescription.text = theCurrentRec!.overview
        
        if theCurrentRec!.poster_path != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + theCurrentRec!.poster_path!)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data:data!)
            poster.image = image
        }
    }

}


