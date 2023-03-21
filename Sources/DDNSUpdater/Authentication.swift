//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation

public protocol Authentication {
    func authenticate(request: URLRequest) -> URLRequest
}
