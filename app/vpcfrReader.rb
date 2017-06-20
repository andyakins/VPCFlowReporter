require_relative 'vpcfrInterfaceNotImplementedError'

# Module intended to represent an interface for readers. Should be included
# in classes that are used for inputing the source data.
#
# @author Andy Akins
# @since 1.0.0
module VPCFRReader

  attr_accessor :source
  attr_accessor :columnNames

  # Method that reads the source data, formats each row into a Hash
  # of columns with their values, and returns an Array of all rows.
  #
  # This function must be overridden by implentation classes.
  #@return [Array[Hash]] list of all rows of the imput source, with each row as a Hash of column => value.
  #@raise [VPCFR::InterfaceNotImplementedError] Exception thrown if the function has not been overridden.
  def read
    raise VPCFR::InterfaceNotImplementedError.new("The read function must be implemented.")
  end
end
