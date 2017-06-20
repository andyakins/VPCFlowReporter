require_relative 'vpcfrConfig'

module VPCFR

  # Class that takes all of the VPCFR components and chains them together
  # to produce the result:
  #
  # VPCFRReader > VPCFRParser > VPCFRFormatter > VPCFRWriter
  #
  # The specific instances of those classes are provided by the VPCFRConfig,
  # which creates them based upon the submitted arguments.
  #
  #@see VPCFRConfig
  #@see VPCFRFormatter
  #@see VPCFRReader
  #@see VPCFRWriter
  #@author Andy Akins
  #@since 1.0.0
  class VPCFRRunner

    # Method that drives the workflow.
    #
    #@param [Array[String]] args Listing of command line arguments, often from ARGV.
    #@return [Integer] exit code, -1 for error or the number of records in the output.
    def run(args)
      config = VPCFRConfig.new(args) #Load command arguments

      if config.isGood?
        begin
          data = config.reader.read # Load data into array of maps
          parsedData = config.parser.parse(data) #Pull out relevant rows and aggregate
          formattedData = config.formatter.format(parsedData) #Format data
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
end
