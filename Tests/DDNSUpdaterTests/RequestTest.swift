//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation
import XCTest
@testable import DDNSUpdater

final class RequestTest: XCTestCase {
    func testIPUpdateRequestFormat() throws {
        let hostname = "test.com"
        let ip = "192.0.0.1"
        let request = IPUpdateRequest(hostname: hostname, ip: ip)
        
        let builtRequest = try request.buildRequest(serviceHostname: "example.com")
        
        XCTAssertEqual("https://example.com/nic/update?hostname=test.com&myip=192.0.0.1", builtRequest.url?.absoluteString)
    }
    
    func testIPUpdaterRequestOptionalIPFormat() throws {
        let hostname = "test.com"
        let request = IPUpdateRequest(hostname: hostname)
        
        let builtRequest = try request.buildRequest(serviceHostname: "example.com")
        
        XCTAssertEqual("https://example.com/nic/update?hostname=test.com", builtRequest.url?.absoluteString)
    }
}
