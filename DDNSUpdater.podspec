Pod::Spec.new do |s|
    s.name                      = 'DDNSUpdater'
    s.version                   = '1.0.0'
    s.summary                   = 'Swift code able to update the IP for a hostname hosted using a Dynamic DNS service'
    s.description               = <<-DESC
    Swift code able to update the IP for a hostname hosted using a Dynamic DNS service, like No-ip(https://www.noip.com/) or similar
    DESC
    s.homepage                  = 'https://github.com/igorcferreira/DDNSUpdater'
    s.license                   = { :type => 'MIT', :file => 'LICENSE' }
    s.author                    = { 'Igor Ferreira' => 'https://github.com/igorcferreira' }
    s.source                    = { :git => 'https://github.com/igorcferreira/DDNSUpdater.git', :tag => "#{s.version}" }
    s.ios.deployment_target     = '13.0'
    s.tvos.deployment_target    = '13.0'
    s.watchos.deployment_target = '8.0'
    s.osx.deployment_target     = '13.0'
    s.swift_version             = '5'
    s.source_files              = 'Sources/DDNSUpdater/**/*.swift'
end
