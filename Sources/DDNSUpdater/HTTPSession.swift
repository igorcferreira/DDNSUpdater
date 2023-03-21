//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation

public protocol HTTPSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
extension URLSession: HTTPSession {
#if os(iOS)
    public func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        return try await self.data(for: request)
    }
#endif
}


