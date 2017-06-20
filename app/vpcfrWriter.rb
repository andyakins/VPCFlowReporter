require_relative 'vpcfrInterfaceNotImplementedError'

# Module intended to represent an interface for writers. Should be included
# in classes that are used for outputing the report
#
# @author Andy Akins
# @since 1.0.0
module VPCFRWriter
  attr_accessor :destination

  # Writes the given String to the local file destination.
  #
  #@param [String] data Data to be saved to file.
  #@raise [VPCFR::InterfaceNotImplementedError] Exception thrown if the function has not been overridden.
  def write(data)
    raise VPCFR::InterfaceNotImplementedError.new("The write(data) function must be implemented.")
  end
end
