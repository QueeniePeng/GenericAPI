//
//  HTTP.swift
//  GenericAPI
//
//  Created by Queenie Peng on 4/10/19.
//  Copyright © 2019 Queenie Peng. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var status: HTTPResponse? {
        return HTTPResponse(rawValue: statusCode)
    }
}

enum HTTPResponse: Int, Error {
    
    case informational
    case success
    case redirection
    case clientError
    case serverError
    case undefined
    
    var responseType: HTTPResponse {
        switch self.rawValue {
            
        case 100..<200:
            return .informational
            
        case 200..<300:
            return .success
            
        case 300..<400:
            return .redirection
            
        case 400..<500:
            return .clientError
            
        case 500..<600:
            return .serverError
            
        default:
            return .undefined
        }
    }
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

enum HTTPHeader {
    case contentType(String)
    case authorization(String)

    var header: (field: String, value: String) {
        switch self {
        case .contentType(let value):   return (field: "content-type", value: value)
        case .authorization(let value): return (field: "authorization", value: value)
        }
    }
}
