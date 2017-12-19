//
//  Movie.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie : Mappable {
    
    var id : Any?
    var title : String?
    var posterPath : String?
    var releaseDate : String?
    var overview : String?
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        id              <- map["id"]
        title           <- map["title"]
        posterPath     <- map["poster_path"]
        releaseDate    <- map["release_date"]
        overview        <- map["overview"]
    }
}
