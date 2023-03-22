# DDNSUpdater

Package with a Swift code able to update the IP for a hostname hosted using a Dynamic DNS service, like [No-ip](https://www.noip.com/) or similar.

The updater returns a String with the content returned by the DDNS service. For example: `nochg 192.0.0.1` (where "nochg" means "no change" in this context) or `good 192.168.0.1`.

The [updateddns](Sources/updateddns/updateddns.swift) command line tool can be used as an example of how to integrate with the DDNSUpdater code.

### Library Usage

```swift
import DDNSUpdater

let authentication = BaseAuthentication(username: "account_username", password: "Account Password")
let updater = DDNSUpdater(authentcation: authentication, serviceHostname: "dynupdate.no-ip.com")
try await updater.perform(request: IPUpdateRequest(hostname: "myserver.com"))
```

### Terminal command usage

```sh
# From source-code
$ swift run updateddns --username 'account_username' --password 'Account Password' --hostname 'myserver.com' --ddnsServer 'dynupdate.no-ip.com'

# From built binary
$ updateddns --username 'account_username' --password 'Account Password' --hostname 'myserver.com' --ddns-server 'dynupdate.no-ip.com'
```

### License

[MIT](LICENSE)
