//
//  EmailModel.swift
//  GenericAPI
//
//  Created by Queenie Peng on 4/10/19.
//  Copyright © 2019 Queenie Peng. All rights reserved.
//

import Foundation

protocol JSON {
    func toDictionary() -> [String: Any]
}

class Email: Encodable, JSON {
    let recipients: [String]
    let subject: String
    let content: String
    let sender: String
    
    init(recipients: [String],
         subject: String,
         content: String,
         sender: String) {
        self.recipients = recipients
        self.subject = subject
        self.content = content
        self.sender = sender
    }

    func toDictionary() -> [String: Any] {
        var to = [String: String]()
        for recipient in recipients {
            to["email"] = recipient
        }
        return [
            "personalizations": [["to": [to]]],
            "from": ["email": sender],
            "subject": subject,
            "content": [["type": "text/plain", "value": content]]
            ] as [String : Any]
    }
}
