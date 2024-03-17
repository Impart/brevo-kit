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
    
    private let apiUrl = "https://api.brevo.com/v3"
    private let httpClient: HTTPClient
    private let apiKey: String
    
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
        
        if response.status != .ok &&
            response.status != .accepted &&
            response.status != .created {
            throw BrevoError(response: response)
        }
        
    }
}

public struct BrevoError: Error {
    
    let response: HTTPClient.Response
    
    init(response: HTTPClient.Response) {
        self.response = response
    }
    
    var localizedDescription: String {
        
        let body: String
        
        if let buffer = response.body {
            body = String(buffer: buffer)
        } else {
            body = "<empty body>"
        }
        
        return "Brevo API error: \(response.status) : \(body)"
    }
    
}
