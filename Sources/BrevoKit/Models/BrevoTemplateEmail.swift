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
    }
    
    let to: [Recipient]
    let templateId: Int
    let params: [String: String]
    
}
