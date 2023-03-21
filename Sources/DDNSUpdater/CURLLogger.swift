//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation

public struct CURLLogger: Logger {
    
    public init() {}
    
    public func log(request: URLRequest) {
#if DEBUG
        var lines = ["curl -v"]
        if let method = request.httpMethod {
            lines += ["-X \(method)"]
        }
        if let headers = request.allHTTPHeaderFields {
            lines += headers.map({ (key, value) in "-H '\(key): \(value)'" })
        }
        if let url = request.url?.absoluteString {
            lines += ["'\(url)'"]
        }
        
        print(lines.joined(separator: " \\\n"))
#endif
    }
    
    public func log(response: URLResponse) {
#if DEBUG
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        print("Response code: \(httpResponse.statusCode)")
#endif
    }
}
