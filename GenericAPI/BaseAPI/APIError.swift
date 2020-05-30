//
//  APIError.swift
//  GenericAPI
//
//  Created by Queenie Peng on 4/10/19.
//  Copyright © 2019 Queenie Peng. All rights reserved.
//

import Foundation

enum APIError: Error, Equatable {
    case invalidURL
    case invalidBase
    case invalidJSON
    case invalidTask
    case invalidSession
    case invalidResponse
    case responseFailed(statusCode: Int)
}
