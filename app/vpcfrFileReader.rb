require_relative 'vpcfrReader'

module VPCFR

  # Implementation class of the VPCFRReader template, intended to read source
  # input from a local file and convert it to an Array of Hashes, with each
  # Hash being comprised of the collection columnName => columnValue of a row.
  #
  # @author Andy Akins
  # @since 1.0.0
  class VPCFRFileReader
    include VPCFRReader
    # Class constructor, simply initializes the instance variables.
    #
    # @param [Array[String]] columnNames List of all of the column names from the source input.
    def initialize(columnNames)
      @columnNames = columnNames
    end

    # Main function to read in the source input from a file and convert to a
    # Array of Hashes.
    #
    #@return [Array[Hash]] The contents of the source file, read in and converted.
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
