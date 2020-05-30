//
//  SendGridClient.swift
//  GenericAPI
//
//  Created by Queenie Peng on 4/10/19.
//  Copyright © 2019 Queenie Peng. All rights reserved.
//

import Foundation


class SendGridClient: APIClient {
    
    var session: URLSession?

    init(_ config: URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }

    convenience init() {
        self.init(.default)
    }
}

extension SendGridClient {
    
    func sendEmail(from sendGrid: SendGrid,
                   email: Email,
                   completion: @escaping (Result<HTTPURLResponse, APIError>) -> Void) {
        guard let request = try? sendGrid.getPostRequest(with: email,
                                                         headers: [HTTPHeader.contentType("application/json"),
                                                                   HTTPHeader.authorization("Bearer " + sendGrid.apiKey)]) else { return }
        post(request: request, model: email, completion: completion)
    }
}
