module VPCFR

  # Class responsible for taking the Array of Hash objects created from
  # a VPCFRReader object, interating through them, and producing the parsed
  # data that matches the type of records that were requested.
  #
  # In addition, the data created can be aggregate totals of the count
  # of records that match the search criteria.
  #
  # Pattern matching can be based on straigh equality (default) or through
  # a regular expression.
  #
  # The data returned is a Hash if the report has been aggregated (one record
  # for each aggregation, with a value of the count) or an Array if the
  # report is non-aggregated (each matching record is a row).
  #
  # @author Andy Akins
  # @since 1.0.0
  class VPCFRParser

    # Constructor, initializing all of the instance variables to set
    # parsing behavior.
    #
    #@param [String] aggregateColumn Name of the column that data should be aggregated on.
    #@param [String] checkColumn Name of the column that the pattern should be compared against for matching.
    #@param [String] pattern Value of the pattern to search for, or a regular expression (in String form) if regex is true.
    #@param [Boolean] regex Flag to signify if the search should perform exact matches or regular expression matches.
    def initialize(aggregateColumn, checkColumn, pattern, regex)
      @aggregateColumn = aggregateColumn
      @checkColumn = checkColumn
      @regex = regex
      if @regex == true
        @pattern = /#{pattern}/
      else
        @pattern = pattern
      end
    end

    # Central method which performs the interation over the provided data and searches for matches
    # based on the initialization, creating either a Hash or Array of data that represents only
    # the data searched for, or a count of its aggregated.
    #
    #@param [Array[Hash]] data Input data from a VPCFRReader, each row is a Hash record, and the column names are the Hash keys.
    #@return [Array] if aggregation is not performed, each row is a matching record stored as a Hash with column names and their values.
    #@return [Hash] if aggregation is performed, each key => value pair representing an aggregation and its count of matched records.
    def parse(data)
      parsedData = Hash.new(0)
      rawData = []
      data.each do |row|
        match = false

        if @regex == true
          check = row[@checkColumn] =~ @pattern
          if check != nil
            match = true
          end
        else
          if row[@checkColumn] == @pattern
            match = true
          end
        end

        if match == true
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
