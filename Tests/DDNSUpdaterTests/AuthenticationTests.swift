//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation
import XCTest
@testable import DDNSUpdater

final class AuthenticationTests: XCTestCase {
    func testEncoding() throws {
        let username = "testUsername"
        let password = "Test Password"
        let authentication = BaseAuthentication(username: username, password: password)
        
        let request = authentication.authenticate(request: URLRequest(url: URL(string: "https://example.com")!))
        
        XCTAssertEqual(1, request.allHTTPHeaderFields?.count)
        XCTAssertEqual("Basic dGVzdFVzZXJuYW1lOlRlc3QgUGFzc3dvcmQ=", request.allHTTPHeaderFields?["Authorization"])
    }
}
