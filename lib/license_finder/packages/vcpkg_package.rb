# frozen_string_literal: true

module LicenseFinder
    class VcpkgPackage < Package
      def initialize(name, version, license_text, url, options = {})
        super(name, version, options)
        @license = License.find_by_text(license_text.to_s)
        @homepage = url
      end
  
      def licenses_from_spec
        [@license].compact
      end
  
      def package_manager
        'vcpkg'
      end
  
      def package_url
        "https://github.com/microsoft/vcpkg/tree/master/ports/#{CGI.escape(name)}/vcpkg.json"
      end
    end
  end
  