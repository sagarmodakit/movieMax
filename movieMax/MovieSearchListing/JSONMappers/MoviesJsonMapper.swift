//
//  MoviesJsonMapper.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation
import ObjectMapper

class MoviesJsonMapper: Mappable { 
    var page : Any?
    var total_results : Any?
    var total_pages : Any?
    var results : [Movie]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        page            <- map["page"]
        total_results   <- map["total_results"]
        total_pages     <- map["total_pages"]
        results          <- map["results"]
    }
    
}
