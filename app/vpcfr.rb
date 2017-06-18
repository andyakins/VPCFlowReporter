#! /usr/bin/env ruby

require_relative 'VPCFRConfig'

# Load command line parameters
module VPCFR

  class VPCFRRunner
    def run
      config = VPCFRConfig.new(ARGV)
      if config.isGood?
        begin
          data = config.reader.read # Load data into array of maps
          parsedData = config.parser.parse(data) #Pull out relevant rows and aggregate
          puts parsedData
          formattedData = config.formatter.format(parsedData) #Format data
          puts formattedData
          config.writer.write(formattedData) #Write output
          parsedData.length # Return the number of result entries as exit code
        rescue Exception => exception
          puts exception
          -1
        end
      else
        puts config.message
        -1 #error out
      end
    end
  end

  runner = VPCFRRunner.new
  exitcode = runner.run
  exit(exitcode)

end
