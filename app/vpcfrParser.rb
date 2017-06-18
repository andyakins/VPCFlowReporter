module VPCFR
  class VPCFRParser

    def initialize(aggregateColumn, checkColumn, pattern)
      @aggregateColumn = aggregateColumn
      @checkColumn = checkColumn
      @pattern = pattern
    end

    def parse(data)
      parsedData = Hash.new(0)
      rawData = []
      data.each do |row|
        if row[@checkColumn] == @pattern
          if @aggregateColumn == 'none'
            rawData.push(row)
          else
            parsedData[row[@aggregateColumn]] += 1
          end
        end
      end
      if @aggregateColumn == 'none'
        rawData
      else
        parsedData
      end
    end
  end
end
