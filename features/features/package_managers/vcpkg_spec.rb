# frozen_string_literal: true

require_relative '../../support/feature_helper'

describe 'vcpkg Dependencies' do
  let(:vcpkg_developer) { LicenseFinder::TestingDSL::User.new }

  specify 'are shown in reports for a project' do
    LicenseFinder::TestingDSL::VcpkgProject.create
    vcpkg_developer.run_license_finder
    expect(vcpkg_developer).to be_seeing_line 'range-v3, 0.10.0, MIT'
  end
end
