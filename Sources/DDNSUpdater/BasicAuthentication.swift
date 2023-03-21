//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation

public struct BaseAuthentication: Authentication {
    let codedAuthentication: String
    
    public init(username: String, password: String) {
        self.codedAuthentication = "\(username):\(password)".data(using: .utf8)!.base64EncodedString()
    }
    
    public func authenticate(request: URLRequest) -> URLRequest {
        var requestCopy = request
        requestCopy.addValue("Basic \(self.codedAuthentication)", forHTTPHeaderField: "Authorization")
        return requestCopy
    }
}
