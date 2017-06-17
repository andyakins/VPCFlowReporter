require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/rspec-support-3.6.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/rspec-core-3.6.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/diff-lcs-1.3/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/rspec-expectations-3.6.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/rspec-mocks-3.6.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/rspec-3.6.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/coderay-1.1.1/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/aws-sigv4-1.0.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/jmespath-1.3.1/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/aws-sdk-core-2.9.42/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/aws-sdk-resources-2.9.42/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/aws-sdk-2.9.42/lib"
$:.unshift "#{path}/"
