//
//  File.swift
//  
//
//  Created by Igor Ferreira on 22/3/23.
//

import Foundation
import ArgumentParser

@main
enum CLI {
    static func main() async {
        await updateddns.main()
    }
}

extension ParsableCommand {
    static func main() async {
        do {
            var command = try parseAsRoot(nil)
            if var asyncCommand = command as? AsyncParsableCommand {
                try await asyncCommand.runAsync()
            } else {
                try command.run()
            }
            exit(withError: nil)
        } catch {
            exit(withError: error)
        }
    }
}

protocol AsyncParsableCommand: ParsableCommand {
    mutating func runAsync() async throws
}
