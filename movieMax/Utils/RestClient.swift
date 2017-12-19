//
//  RestClient.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RestClient {
    
    static var currentRequest : Request?
    
    static let apiKey = "api_key"
    
    class func authorizedGetApiCall(url:String, parameters:[String:AnyObject], onSuccess : @escaping (Result<MoviesJsonMapper>) -> Void, onError : (_ error : AnyObject) -> Void, code : Int){
        
        var parameters : [String:AnyObject] = parameters
        parameters[RestClient.apiKey] = movieApiKey as AnyObject
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let t = baseURLString + url
        let URLT = URL(string: t)
        print(URLT)
        print(parameters)
        
        Alamofire.request(URLT!, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { responseJson in
            
            
            switch responseJson.result {
                case .success(let data):
                
                if let result = data as? [String : Any] {
                    if let mapper = MoviesJsonMapper(JSON: result) {
                        
                        onSuccess(Result.Success(mapper))

                    }
                }
                else{
                    onSuccess(Result.JSONParsingFailure())
                }
            case .failure(let error):
                
                let error = RestError(code: 601, message: error.localizedDescription)
                onSuccess(Result.Error(error))
            }
                
            }
        
        }
    
}
