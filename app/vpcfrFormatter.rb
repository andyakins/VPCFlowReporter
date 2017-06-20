require_relative 'vpcfrInterfaceNotImplementedError'

# Module intended to represent an interface for formatters. Should be included
# in classes that are used for formatting the report
#
# @author Andy Akins
# @since 1.0.0
module VPCFRFormatter

  # Method that takes either an Array or Hash of parsed data and returns
  # a String containing that data in a formatted report.
  #
  # For information on the structure of the incoming data refer to VPCFRParser
  #
  # This function must be overridden by implentation classes.
  #@see VPCFR::VPCFRParser
  #@param [Array,Hash] data VPCFRParser created output that is to be formatted.
  #@return [String] Formatted report String generated from the input data.
  #@raise [VPCFR::InterfaceNotImplementedError] Exception thrown if the function has not been overridden.
  def format(data)
    raise VPCFR::InterfaceNotImplementedError.new("The format(data) function must be implemented.")
    ''
  end
end
