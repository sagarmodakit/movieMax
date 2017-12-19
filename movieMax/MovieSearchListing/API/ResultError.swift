//
//  ResultError.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation
import UIKit

enum Result<MovieMax> {
    case Success(MovieMax)
    case Error(RestError)
    case JSONParsingFailure()
}

class RestError: Error {
    public var code: Int = -1
    public var message: String = "Error occurred."
    
    public init(code: Int, message: String)
    {
        self.code = code
        self.message = message
    }
    
}

