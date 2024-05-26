//
//  Collections.swift
//  WilsonWang-Lab4
//
//  Created by Wilson Wang on 10/30/23.
//

import UIKit

class Collections: UICollectionViewCell {
    
    let movieTitle = UILabel(frame: CGRect(x: 0, y: 80, width: 80, height: 40))
    let moviePoster = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 120))
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.removeFromSuperview()
        moviePoster.removeFromSuperview()
    }
}
