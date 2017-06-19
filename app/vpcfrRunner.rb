require_relative 'vpcfrConfig'

module VPCFR
class VPCFRRunner
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
