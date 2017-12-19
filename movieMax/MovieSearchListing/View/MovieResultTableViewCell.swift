//
//  MovieResultTableViewCell.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class MovieResultTableViewCell: UITableViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateDataFrom(movieObject : Movie) {
        
        self.movieTitle.text = movieObject.title
        if let releaseDate = movieObject.releaseDate {
            self.releaseDate.text = "Release Date: \(releaseDate)"
        }
        
        self.overview.text = movieObject.overview
        
        var imageURL = URL(string: "")
        if let imagePathString  = movieObject.posterPath {
            imageURL = URL(string: "\(baseImageUrl)\(imagePathString)")
        }
        
        self.moviePosterImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: moviePosterPlaceholderImageName), options: .continueInBackground, completed: nil)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
