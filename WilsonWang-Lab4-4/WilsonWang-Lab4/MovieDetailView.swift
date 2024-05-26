//
//  MovieDetailView.swift
//  WilsonWang-Lab4
//
//  Created by Wilson Wang on 10/30/23.
//


//movie data from: https://www.themoviedb.org/?language=en-US

import UIKit

class MovieDetailView: UIViewController {
    
    var currentMovie: Movie?
    var image:UIImage?
    let favlist = FavList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        self.title = currentMovie!.title
        
        let theImageFrame = CGRect(x: view.frame.midX - 160, y: 100, width: 320, height: 480)
        let imageView = UIImageView(frame: theImageFrame)
        if currentMovie!.poster_path != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + currentMovie!.poster_path!)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data:data!)
            imageView.image = image
            self.image = image
        }
        view.addSubview(imageView)
        
        let theDescriptionFrame = CGRect(x: view.frame.midX - 170, y: 650, width: 340, height: 70)
        let descriptionView = UITextView(frame: theDescriptionFrame)
        descriptionView.text = currentMovie!.overview
        descriptionView.isEditable = false
        descriptionView.font = descriptionView.font?.withSize(14)
        view.addSubview(descriptionView)
        
        let theVoteImageFrame = CGRect(x: view.frame.maxX - 100, y: 590, width: 64, height:64)
        let voteImageView = UIImageView(frame: theVoteImageFrame)
        voteImageView.image = UIImage(named: "star")
        view.addSubview(voteImageView)
        
        let theVoteFrame = CGRect(x: view.frame.maxX - 100, y: 600, width: 100, height:45)
        let voteView = UILabel(frame: theVoteFrame)
        voteView.text = String(currentMovie!.vote_average!)
        voteView.font = voteView.font.withSize(45)
        view.addSubview(voteView)
        
        let theDateFrame = CGRect(x: 40, y: 600, width: 200, height: 17)
        let dateView = UILabel(frame: theDateFrame)
        dateView.text = "Release Date:"
        dateView.font = dateView.font.withSize(17)
        view.addSubview(dateView)
    
        
        let theReleaseFrame = CGRect(x: 40, y: 630, width: 200, height: 17)
        let releaseView = UILabel(frame: theReleaseFrame)
        releaseView.text = currentMovie!.release_date!
        releaseView.font = releaseView.font.withSize(17)
        view.addSubview(releaseView)
        
        let theFavFrame = CGRect(x: 105, y: 735, width: 53, height: 53)
        let favView = UIButton(frame: theFavFrame)
        favView.setImage(UIImage(named: "beforelike"), for: .normal)
        favView.addTarget(self, action: #selector(addFav(_:)), for: .touchUpInside)
        view.addSubview(favView)
        
        let theDownFrame = CGRect(x: view.frame.maxX - 165, y: 735, width: 53, height: 53)
        let downView = UIButton(frame: theDownFrame)
        downView.setImage(UIImage(named: "download"), for: .normal)
        downView.addTarget(self, action: #selector(downloadPoster(_:)), for: .touchUpInside)
        view.addSubview(downView)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // 2 buttons: fav, download
    @objc private func addFav(_ sender: UIButton) {
        sender.setImage(UIImage(named: "like"), for: UIControl.State.normal)
        favlist.add(title: currentMovie!.title)
    }
    
    func alert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc private func downloadPoster(_ sender: UIButton?) {
        if let image = self.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            alert(title: "Saved", message: "The poster has been saved to Photo Library.")
        }
    }
    
}

// TODO: FAV
