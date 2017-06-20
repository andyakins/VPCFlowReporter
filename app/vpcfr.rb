#! /usr/bin/env ruby

# Simple ruby script to envoke the actual program,
# used to make testing easier
require_relative 'vpcfrRunner'

runner = VPCFR::VPCFRRunner.new
exitcode = runner.run(ARGV)
exit(exitcode)
