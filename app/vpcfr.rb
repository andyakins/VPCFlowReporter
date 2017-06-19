#! /usr/bin/env ruby
require_relative 'vpcfrRunner'


  runner = VPCFR::VPCFRRunner.new
  exitcode = runner.run(ARGV)
  exit(exitcode)
