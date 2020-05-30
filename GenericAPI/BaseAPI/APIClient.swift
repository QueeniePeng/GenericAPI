//
//  APIClient.swift
//  GenericAPI
//
//  Created by Queenie Peng on 4/10/19.
//  Copyright © 2019 Queenie Peng. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession? { get }
}

extension APIClient {
    func post<T: Encodable>(request: URLRequest,
                            model: T,
                            completion: @escaping (Result<HTTPURLResponse, APIError>) -> Void)  {
        
        guard let session = session else {
            completion(Result.failure(APIError.invalidSession))
            return
        }
        
        let task = session.dataTask(with: request) { _, response, error in

            if let error = error {
                print(error)
                completion(Result.failure(APIError.invalidTask))
            }
            guard let response = response as? HTTPURLResponse else {
                completion(Result.failure(APIError.invalidResponse))
                return
            }

            if response.status?.responseType == .success {
                completion(Result.success(response))
            } else {
                completion(Result.failure(APIError.responseFailed(statusCode: response.statusCode)))
            }
        }
        task.resume()
    }
}
