# frozen_string_literal: true

require_relative '../../support/feature_helper'
require_relative '../../../lib/license_finder/version'

describe 'Bundler Dependencies' do
  let(:bundler_developer) { LicenseFinder::TestingDSL::User.new }

  specify 'are shown in reports' do
    LicenseFinder::TestingDSL::BundlerProject.create
    puts 'bundler project created'
    bundler_developer.run_license_finder
    expect(bundler_developer).to be_seeing_line "license_finder, #{LicenseFinder::VERSION}, MIT"
  end

  specify 'works with vendored bundle' do
    LicenseFinder::TestingDSL::VendorBundlerProject.create
    puts 'bundler project created'
    bundler_developer.run_license_finder
    expect(bundler_developer).to be_seeing_line 'rake, 12.3.0, MIT'
  end
end
