require_relative 'vpcfrReader'

module VPCFR
  class VPCFRFileReader < VPCFRReader

    def initialize(columnNames)
      @columnNames = columnNames
    end

    def read
      data = []
      File.open(@source) do |file|
        while line = file.gets
          data.push(Hash[@columnNames.zip(line.split(' '))])
        end
      end
      data
    end
  end
end
