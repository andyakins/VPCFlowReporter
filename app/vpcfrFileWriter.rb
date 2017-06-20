require_relative 'vpcfrWriter'

module VPCFR

  # Implementation class of the VPCFRWriter template, intended to write a
  # formatted string of data to a local file.
  #
  # @author Andy Akins
  # @since 1.0.0
  class VPCFRFileWriter
    include VPCFRWriter

    # Writes the given String to the local file destination.
    #
    #@param [String] data Data to be saved to file.
    def write(data)
      File.open(@destination, 'w') do |file|
        file.print data
      end
    end
  end
end
