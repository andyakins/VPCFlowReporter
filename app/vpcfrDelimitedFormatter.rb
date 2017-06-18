require 'csv'

module VPCFR
  class VPCFRDelimitedFormatter

    attr_accessor :delimiter

    def initialize(columnNames)
      @columnNames = columnNames
      @delimiter = ','
    end

    def format(data)
      csvData = CSV.generate(:col_sep => @delimiter) do |csv|
        if data.instance_of? Hash
          data.each_key do |key|
            csv << [key,data[key]]
          end
        else
          data.each do |row|
            newrow = []
            @columnNames.each do |name|
              newrow.push(row[name])
            end
            csv << newrow
          end
        end
      end
      csvData
    end
  end
end
