#! /usr/bin/env ruby

require_relative 'VPCFRConfig'

# Load command line parameters
module VPCFR
  config = VPCFRConfig.new(ARGV)
  if config.isGood?
    # Load data
    data = config.reader.read # Load data into array of maps
    parsedData = config.parser.parse(data) #Pull out relevant rows and aggregate
    formattedData = config.formatter.format(parsedData) #Format data
    config.writer.write(formattedData) #Write output
  else
    exit(-1) #error out
  end
  exit(parsedData.length) # Return the number of result entries as exit code
end
