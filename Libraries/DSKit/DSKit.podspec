Pod::Spec.new do |s|
    s.name = 'DSKit'
    s.version = '0.0.1'
    s.summary = 'This module contains all components from DSKit.'
    s.description = <<-DESC
    This module should have all componentes from DSKit supports.
    DESC
    s.homepage = 'https://www.chronustecnologia.com.br/app'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.authors = { 'Jose Julio' => 'jose.julio@chronustecnologia.com.br' }
    s.source = {
        :git => 'https://bancopan.visualstudio.com.mcas.ms/banco-digital/_git/mobile-ios--banco-digital',
        :branch => 'master',
        :tag => s.version.to_s
    }

    s.ios.deployment_target = '15.0'
    s.swift_version = '5.0' if s.respond_to?(:swift_version)

    s.subspec 'Release' do |release|
        release.source_files = "Sources/**/*.swift"
        release.dependency 'SLCommonImages'
        release.frameworks = 'UIKit'
    end
end