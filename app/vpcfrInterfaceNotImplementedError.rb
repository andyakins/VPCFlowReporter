module VPCFR

    # Simple custom exception used by the template modules
    # (VPCFRFormatter, VPCFFRReader, VPCFRWriter) to force overrides
    # of implementing classes
    #
    #@see VPCFRFormatter
    #@see VPCFRReader
    #@see VPCFRWriter
    class InterfaceNotImplementedError < NoMethodError
    end

end
