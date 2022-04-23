# frozen_string_literal: true

require 'license_finder/package_utils/vcpkg_info_parser'

module LicenseFinder
  class Vcpkg < PackageManager
    def possible_package_paths
      [project_path.join('vcpkg.json')]
    end

    def current_packages
      install_command = 'vcpkg install .'
      info_command = 'vcpkg info .'
      Dir.chdir(project_path) { Cmd.run(install_command) }
      info_output, _stderr, _status = Dir.chdir(project_path) { Cmd.run(info_command) }

      info_parser = VcpkgInfoParser.new

      deps = info_parser.parse(info_output)
      deps.map do |dep|
        name, version = dep['name'].split('/')
        url = dep['URL']
        license_file_path = Dir.glob("#{project_path}/licenses/#{name}/**/LICENSE*").first
        VcpkgPackage.new(name, version, File.open(license_file_path).read, url) unless name == 'vkpkg.json'
      end.compact
    end
  end
end
