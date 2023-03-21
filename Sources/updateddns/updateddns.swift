import Foundation
import ArgumentParser
import DDNSUpdater

struct updateddns: AsyncParsableCommand {
    @Option(name: .shortAndLong, help: "DDNS account username")
    var username: String
    @Option(name: .shortAndLong, help: "DDNS account password")
    var password: String
    @Option(name: .shortAndLong, help: "Hostname that will be updated")
    var hostname: String
    @Option(name: .shortAndLong, help: "Machine IP. If not provided, the IP received by the DDNS server will be used")
    var ip: String?
    @Option(name: .shortAndLong, help: "Hostname of the DDNS service. Defaults to dynupdate.no-ip.com")
    var ddnsServer: String?
    
    mutating func runAsync() async throws {
        let authentication = BaseAuthentication(username: self.username, password: self.password)
        let updater = DDNSUpdater(authentcation: authentication, serviceHostname: self.ddnsServer, logger: CURLLogger())
        let request = IPUpdateRequest(hostname: self.hostname, ip: self.ip)
        print("Updating IP...")
        let response = try await updater.perform(request: request)
        print("Response: \(response ?? "")")
    }
}
