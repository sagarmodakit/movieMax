//
//  SearchApi.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchAPI{
    
    enum SearchEndPoints : String{
        case searchMovie = "search/movie"
     }
    
    enum SearchResponseKeys : String{
        case
        results = "results"
    }
    
    class Payload {
        var page :Int = 0
        var search_string = ""
        enum SearchRequestKeys : String{
            case
            page = "page",
            search_string = "query"
        }
    }
    
    class func getSearchResults(payload : Payload, onSuccess : @escaping (Result<MoviesJsonMapper>) -> Void, onError : @escaping (_ error : AnyObject) -> Void) {
        
        let params : [String : AnyObject] = [Payload.SearchRequestKeys.page.rawValue : payload.page as AnyObject, Payload.SearchRequestKeys.search_string.rawValue : payload.search_string as AnyObject]
        
        RestClient.authorizedGetApiCall(url: SearchEndPoints.searchMovie.rawValue, parameters: params, onSuccess: { (result) in
            
            onSuccess(result)
 
        }, onError: { (error) in
            //
            onError(error)
        }, code: 0)
        
    }
    

}

