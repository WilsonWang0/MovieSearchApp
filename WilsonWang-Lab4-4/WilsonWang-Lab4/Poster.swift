//
//  Poster.swift
//  WilsonWang-Lab4
//
//  Created by Wilson Wang on 10/30/23.
//

import UIKit

class Poster: UICollectionViewCell {
    
    let movieTitle = UILabel(frame: CGRect(x: 0, y: 140, width: 120, height: 40))
    let moviePoster = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 180))
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.removeFromSuperview()
        moviePoster.removeFromSuperview()
    }
}
