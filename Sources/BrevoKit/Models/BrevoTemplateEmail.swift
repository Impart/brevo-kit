//
//  BrevoTemplateEmail.swift
//
//
//  Created by Marcel Borsten on 21/02/2024.
//

import Foundation

public struct BrevoTemplateEmail: Codable {
    
    public struct Recipient: Codable {
        let email: String
        let name: String

        public init(email: String, name: String) {
            self.email = email
            self.name = name
        }
    }
    
    let to: [Recipient]
    let templateId: Int
    let params: [String: String]

    public init(to: [Recipient], templateId: Int, params: [String: String]) {
        self.to = to
        self.templateId = templateId
        self.params = params
    }
    
}
