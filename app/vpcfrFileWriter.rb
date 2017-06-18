require_relative 'vpcfrWriter'
module VPCFR
  class VPCFRFileWriter < VPCFRWriter
    def write(data)
      File.open(@destination, 'w') do |file|
        file.puts data
      end
    end
  end
end
