//
//  SendGrid.swift
//  GenericAPI
//
//  Created by Queenie Peng on 4/10/19.
//  Copyright © 2019 Queenie Peng. All rights reserved.
//

import Foundation

enum SendGrid: Endpoint {
    case sendEmail

    var apiKey: String {
        return "YOUR_API_HERE"
    }

    var base: String {
        return "https://api.sendgrid.com"
    }

    var path: String {
        switch self {
        case .sendEmail: return "/v3/mail/send"
        }
    }
}
