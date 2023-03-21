//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation
import XCTest
@testable import DDNSUpdater

struct HTTPSessionValidator: HTTPSession {
    
    let validationBlock: (URLRequest) async throws -> (Data, URLResponse)
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await self.data(for: request, delegate: nil)
    }
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        return try await self.validationBlock(request)
    }
}

final class UpdaterTest: XCTestCase {
    func testFinalRequest() async throws {
        let authentication = BaseAuthentication(username: "username", password: "password")
        let request = IPUpdateRequest(hostname: "test.com", ip: "192.0.0.1")
        let updater = DDNSUpdater(authentcation: authentication, serviceHostname: "example.com", session: HTTPSessionValidator { (urlRequest) in
            XCTAssertEqual("https://example.com/nic/update?hostname=test.com&myip=192.0.0.1", urlRequest.url?.absoluteString)
            XCTAssertEqual(3, urlRequest.allHTTPHeaderFields?.count)
            XCTAssertEqual("Basic dXNlcm5hbWU6cGFzc3dvcmQ=", urlRequest.allHTTPHeaderFields?["Authorization"])
            XCTAssertEqual("example.com", urlRequest.allHTTPHeaderFields?["Host"])
            XCTAssertEqual("DDNSUpdater", urlRequest.allHTTPHeaderFields?["User-Agent"])
            return ("nochg 192.0.0.1".data(using: .utf8)!, HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
        })
        
        let responseContent = try await updater.perform(request: request)
        XCTAssertEqual("nochg 192.0.0.1", responseContent)
    }
    
    func testServerResponse() async throws {
        let authentication = BaseAuthentication(username: "username", password: "password")
        let request = IPUpdateRequest(hostname: "test.com", ip: "192.0.0.1")
        let updater = DDNSUpdater(authentcation: authentication, serviceHostname: "example.com", session: HTTPSessionValidator { (urlRequest) in
            return ("badauth".data(using: .utf8)!, HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 401, httpVersion: nil, headerFields: nil)!)
        })
        
        do {
            let _ = try await updater.perform(request: request)
            XCTFail()
        } catch {
            let dnsError = try XCTUnwrap(error as? DDNSUpdaterError)
            XCTAssertEqual("Error 401: badauth", dnsError.description)
        }
    }
}
