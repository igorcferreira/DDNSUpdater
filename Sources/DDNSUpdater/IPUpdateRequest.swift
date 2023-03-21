//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation

public struct IPUpdateRequest: Request {
    let hostname: String
    let ip: String?
    
    public init(hostname: String, ip: String? = nil) {
        self.hostname = hostname
        self.ip = ip
    }
    
    public func buildRequest(serviceHostname: String) throws -> URLRequest {
        guard let url = URL(string: "https://\(serviceHostname)/nic/update"), var componets = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw DDNSUpdaterError.serverException(code: URLError.badURL.rawValue, message: nil)
        }
        componets.queryItems = [URLQueryItem(name: "hostname", value: hostname)]
        if let ip = ip {
            componets.queryItems?.append(URLQueryItem(name: "myip", value: ip))
        }
        guard let builtURL = componets.url else {
            throw DDNSUpdaterError.serverException(code: URLError.badURL.rawValue, message: nil)
        }
        return URLRequest(url: builtURL)
    }
}
