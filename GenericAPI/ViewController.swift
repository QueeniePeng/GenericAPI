//
//  ViewController.swift
//  GenericAPI
//
//  Created by Queenie Peng on 4/10/19.
//  Copyright © 2019 Queenie Peng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SendGridClient().sendEmail(from: .sendEmail, email: getEmail()) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }

    func getEmail() -> Email {
        let recipients = ["test@gmail.com"]
        let subject = "Subject"
        let content = "Testing Content"
        let sender = "test@example.com"

        return Email(recipients: recipients,
                     subject: subject,
                     content: content,
                     sender: sender)
    }

}

