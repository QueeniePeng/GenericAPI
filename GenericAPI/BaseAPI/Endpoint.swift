//
//  Endpoint.swift
//  GenericAPI
//
//  Created by Queenie Peng on 4/10/19.
//  Copyright © 2019 Queenie Peng. All rights reserved.
//

import UIKit


protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var apiKey: String { get }
}


extension Endpoint {

    private func isValidURL(with urlString: String) throws -> Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector?.firstMatch(in: urlString,
                                            options: [],
                                            range: NSRange(location: 0, length: urlString.utf16.count)) {
            return match.range.length == urlString.utf16.count
        }
        return false
    }

    func getURLRequest() throws -> URLRequest {
        guard try isValidURL(with: base + path) else            { throw APIError.invalidURL }
        guard var components = URLComponents(string: base) else { throw APIError.invalidBase }
        components.path = path
        guard let url = components.url else                     { throw APIError.invalidURL }

        return URLRequest(url: url)
    }
}


extension Endpoint {

    func getPostRequest<T: JSON>(with model: T,
                                 headers: [HTTPHeader]) throws -> URLRequest {

        var request = try self.getURLRequest()
        request.httpMethod = HTTPMethod.post.rawValue

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: model.toDictionary(),
                                                          options: [])
        } catch(let error) {
            print(error)
            throw APIError.invalidJSON
        }
        headers.forEach { request.addValue($0.header.value,
                                           forHTTPHeaderField: $0.header.field) }
        return request
    }
}
