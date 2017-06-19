#! /usr/bin/env ruby
require_relative('vpcfrRunner')

module VPCFR
  runner = VPCFRRunner.new
  exitcode = runner.run(ARGV)
  exit(exitcode)
end
