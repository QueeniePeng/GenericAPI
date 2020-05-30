//
//  APITests.swift
//  GenericAPITests
//
//  Created by Queenie Peng on 5/18/20.
//  Copyright © 2020 Queenie Peng. All rights reserved.
//

import XCTest

class APITests: XCTestCase {

    class EndpointMock: Endpoint {
        var base: String = ""
        var path: String = ""
        var apiKey: String = ""
    }
    
    class APIClientMock: APIClient {
        var session: URLSession? = nil
    }
    
    struct EmailMock: Encodable, JSON {
        func toDictionary() -> [String : Any] { return [:] }
    }

    var endpoint: EndpointMock?
    var apiClient: APIClientMock?
    var email: EmailMock?

    override func setUp() {
        endpoint = EndpointMock()
        apiClient = APIClientMock()
        email = EmailMock()
    }

    override func tearDown() {
        endpoint = nil
        apiClient = nil
        email = nil
    }

    func testThrowOnInvalidURL() {
        endpoint?.base = "www."
        endpoint?.path = "/nopath/"

        XCTAssertThrowsError(try endpoint?.getURLRequest()) { (error) in
            XCTAssertEqual(error as? APIError, APIError.invalidURL)
        }
    }

    func testPassOnValidURL() {
        endpoint?.base = "www.duckduckgo.com"
        XCTAssertNoThrow(try endpoint?.getURLRequest())
    }
    
    func testErrorInvalidSession() {
        endpoint?.base = "www.duckduckgo.com"
        
        if let request = try? endpoint?.getURLRequest() {
            apiClient?.post(request: request, model: email, completion: { (result) in
                switch result {
                case .success( _): return
                case .failure(let error):
                    XCTAssertEqual(error, APIError.invalidSession)
                }
            })
        }
    }
}
