require_relative 'vpcfrWriter'

module VPCFR

  # Implementation class of the VPCFRWriter template, intended to write a
  # formatted string of data to standard output (generally the screen).
  #
  # @author Andy Akins
  # @since 1.0.0
  class VPCFRSTDOUTWriter
    include VPCFRWriter

    # Writes the given String to standard output.
    #
    #@param [String] data Data to be sent to standard output.
    def write(data)
      $stdout.write data
      $stdout.flush
    end
  end
end
