//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation

public protocol Logger {
    func log(request: URLRequest)
    func log(response: URLResponse)
}
