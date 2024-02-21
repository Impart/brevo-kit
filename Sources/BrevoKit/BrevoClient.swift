//
//  BrevoClient.swift
//
//
//  Created by Marcel Borsten on 21/02/2024.
//

import Foundation
import AsyncHTTPClient
import NIO
import NIOHTTP1
import NIOFoundationCompat

public struct BrevoClient {
    
    let apiUrl = "https://api.brevo.com/v3"
    let httpClient: HTTPClient
    let apiKey: String
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        encoder.keyEncodingStrategy = .useDefaultKeys
        return encoder
    }()

    public init(httpClient: HTTPClient, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }
    
    public func send(email: BrevoTemplateEmail) async throws {
        var headers = HTTPHeaders()
        headers.add(name: "api-key", value: apiKey)
        headers.add(name: "accept", value: "application/json")
        headers.add(name: "content-type", value: "application/json")
        
        let response = try await httpClient.execute(request:
                .init(
                    url: apiUrl + "/smtp/email",
                    method: .POST,
                    headers: headers,
                    body: .data(encoder.encode(email))
                )
        ).get()
        
        guard response.status != .ok && response.status != .accepted else { return }
        
    }
}
