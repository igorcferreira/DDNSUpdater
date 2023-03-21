//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation

public protocol Request {
    func buildRequest(serviceHostname: String) throws -> URLRequest
}
