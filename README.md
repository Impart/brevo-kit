# BrevoKit

![Swift](http://img.shields.io/badge/swift-5.9-brightgreen.svg)
         
         BrevoKit is a Swift package used to communicate with the Brevo API for Server Side Swift Apps.
         It implements the bare minimum to send an email. 
         
         ## Setup
         Add the dependency to Package.swift:
            
            ~~~~swift
         dependencies: [
            ...
                .package(url: "https://github.com/Impart/brevo-kit.git", from: "0.0.1")
         ],
         targets: [
            .target(name: "App", dependencies: [
                .product(name: "BrevoKit", package: "brevo-kit"),
            ]),
            ~~~~
            
            Register the config and the provider.
            
            ~~~~swift
            let httpClient = HTTPClient(...)
            let brevoClient = BrevoClient(httpClient: httpClient, apiKey: "YOUR_API_KEY")
            ~~~~
            
            ## Using the API
            
            You can use all of the available parameters here to build your `BrevoKitEmail`
            Usage in a route closure would be as followed:
                
                ~~~~swift
            import BrevoKit
            
            let email = BrevoTemplateEmail(...)
            try await brevoClient.send(email)
            ~~~~
