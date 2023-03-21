import Foundation

public enum DDNSUpdaterError: LocalizedError, CustomStringConvertible {
    case serverException(code: Int, message: String?)
    
    public var description: String {
        switch self {
        case .serverException(let code, let message):
            if let message = message {
                return "Error \(code): \(message)"
            } else {
                return URLError(URLError.Code(rawValue: code)).localizedDescription
            }
        }
    }
    
    public var errorDescription: String? {
        self.description
    }
}

public struct DDNSUpdater {
    let authentcation: Authentication
    let serviceHostname: String
    let session: HTTPSession
    let logger: Logger?
    
    public init(authentcation: Authentication, serviceHostname: String? = nil, session: HTTPSession = URLSession.shared, logger: Logger? = nil) {
        self.authentcation = authentcation
        self.serviceHostname = serviceHostname ?? "dynupdate.no-ip.com"
        self.session = session
        self.logger = logger
    }

    public func perform(request: Request) async throws -> String? {
        let urlRequest = self.authentcation.authenticate(request: try request.buildRequest(serviceHostname: self.serviceHostname))
            .adding(value: "DDNSUpdater", forHTTPHeaderField: "User-Agent")
            .adding(value: self.serviceHostname, forHTTPHeaderField: "Host")
        
        self.logger?.log(request: urlRequest)
        let (data, response) = try await self.session.data(for: urlRequest)
        self.logger?.log(response: response)
        
        let responseContent: String?
        if data.count > 0 {
            responseContent = String(data: data, encoding: .utf8)
        } else {
            responseContent = nil
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw DDNSUpdaterError.serverException(code: 500, message: responseContent)
        }
        guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            throw DDNSUpdaterError.serverException(code: httpResponse.statusCode, message: responseContent)
        }
        
        return responseContent?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

extension URLRequest {
    func adding(value: String?, forHTTPHeaderField: String) -> URLRequest {
        var request = self
        if let value = value {
            request.addValue(value, forHTTPHeaderField: forHTTPHeaderField)
        } else {
            request.allHTTPHeaderFields?.removeValue(forKey: forHTTPHeaderField)
        }
        return request
    }
}
