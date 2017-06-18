require 'json'

module VPCFR
  class VPCFRJSONFormatter
    def format(data)
      JSON.pretty_generate(data)
    end
  end
end
