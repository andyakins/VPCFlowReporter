require 'optparse'
require_relative 'vpcfrDelimitedFormatter'
require_relative 'vpcfrFileReader'
require_relative 'vpcfrFileWriter'
require_relative 'vpcfrJSONFormatter'
require_relative 'vpcfrParser'
require_relative 'vpcfrS3Writer'
require_relative 'vpcfrSTDOUTWriter'

# Namespace for classes and modules that read VPC Flow Logs, parse for
# certain patterns, format a report, and output the created report.
#
# @author Andy Akins
# @since 1.0.0
module VPCFR

  # Central configuation class for the VPCFR system. Passed a list of
  # arguments (such as from ARGV) the class will parse the arguments,
  # create helper objects to perform the work, and configures those objects
  # based on the arguments given.
  #
  # @author Andy Akins
  # @since 1.0.0
  # @attr_reader [String] aggregateCol Column name to aggregate data on.
  # @attr_reader [String] awsAccessKeyID Value to use for AWS Access Key ID, used for S3 operations.
  # @attr_reader [String] awsRegion Value to use for the AWS region, used for S3 operations.
  # @attr_reader [String] awsSecretAccessKey Value to use for AWS Secret Access Key, used for S3 operations.
  # @attr_reader [String] checkCol Column name to check the pattern against.
  # @attr_reader [Array[String]] columnNames The list of available column names.
  # @attr_reader [String] delimiter Value of the delimiter character used in delimited output/
  # @attr_reader [String] destination Value for the destination location for the report, needs to be approp
  # @attr_reader [VPCFRFormatter] formatter Instance of a VPCFRFormatter-based class that will handle formatting parsed datriate to the writer class.
  # @attr_reader [String] message Status message used for passing information to the end user.
  # @attr_reader [VPCFRParser] parser Instance of a VPCParser class that will handle data parsing.
  # @attr_reader [String] pattern Value to check against the check column for result matches, if regex is true should be a String representation of a regular expression.
  # @attr_reader [VPCFRReader] reader Instance of a VPCFRReader-based class that will handle source input.
  # @attr_reader [Boolean] regex Flag signifying if the pattern is a normal String or a String representation of a regular
  # @attr_reader [String] source Value for the source location for the flow log, needs to be appropriate to the reader class.
  # @attr_reader [String] version The current version of VPCFR.
  # @attr_reader [VPCFRWriter] writer Instance of a VPCFRWriter-based class that will handle report output.a.
  class VPCFRConfig
    attr_reader :aggregateCol, :awsAccessKeyID, :awsSecretAccessKey, :awsRegion,
      :checkCol, :destination, :writer, :formatter, :parser, :pattern, :source,
      :reader, :version, :columnNames, :delimiter, :message, :regex

    # Class constructor, parses the incoming arguments and creates all the helper
    # objects with the correct configuration.
    #
    # @param [Array[String]] argumentList List of the command line arguments - usually ARGV.
    def initialize(argumentList)
      @aggregateCol = 'srcaddr'
      @awsAccessKeyID = ENV["AWS_ACCESS_KEY_ID"] #default to system environment
      @awsSecretAccessKey = ENV["AWS_SECRET_ACCESS_KEY"] #default to system environment
      @awsRegion = ENV["AWS_REGION"] #default to system environment
      @checkCol = 'action'
      @columnNames = ['version','accountid','interfaceid','srcaddr','dstaddr',
        'srcport','dstport','protocol','packets','bytes','start','end',
        'action','logstatus']
      @delimiter = ','
      @destination = nil
      @formatter = nil
      @message = ''
      @parser = nil
      @pattern = 'REJECT'
      @reader = nil
      @regex = false
      @source = nil
      @version = '1.0'
      @writer = nil

      @isGood = true

      # we clone the argument list because OptionParser changes the list,
      # and other things may want ARGV (the most likely incoming argumentList)
      args = argumentList.clone

      # convience variable for -a,--aggregate
      aggregateColumnNames = @columnNames.clone
      aggregateColumnNames.push('none')

      requiredArgs = 2

      parser = OptionParser.new do |opts|

        opts.banner = 'Usage: vpcfr [ options ] source destination'
        opts.on('-a','--aggregate column', aggregateColumnNames,
          'The column to aggregate on, defaults to srcaddr. Allowed: none, version, accountid, interfaceid, srcaddr, dstaddr, srcport, dstport, protocol, packets, bytes, start, end, action, logstatus.') do |a|
          @aggregateCol = a
        end

        opts.on('-c','--check column', @columnNames,
          'The column to check, defaults to action. Allowed: version, accountid, interfaceid, srcaddr, dstaddr, srcport, dstport, protocol, packets, bytes, start, end, action, logstatus.') do |c|
          @checkCol = c
        end

        opts.on('-d', '--destination type', [:file, :s3, :stdout ],
          'The destination type for report type, defaults to s3. Allowed: file, s3') do |d|
          case
          when d == :file
            @writer = VPCFRFileWriter.new
          when d == :stdout
            @writer = VPCFRSTDOUTWriter.new
            requiredArgs = 1
          end
        end

        opts.on('-f','--format type', [:delimited,:json],
          'The format to output the report in, defaults to json. Allowed: delimited, json') do |f|
          case
          when f == :delimited
            @formatter = VPCFRDelimitedFormatter.new(@columnNames)
          end
        end

        opts.on('--delimiter char', String,
          'The character to use as a delimiter in delimited formatting. Defaults to comma (,)') do |delimiter|
          if (@formatter != nil) && (@formatter.instance_of? VPCFRDelimitedFormatter)
            @delimiter = delimiter
            @formatter.delimiter = @delimiter
          else
            @message = "Error: cannot specify --delimiter unless -f delimit is specified first.\n#{opts}"
            @isGood = false
            @isGood
          end
        end

        opts.on('--space', String,
          'Use a space ' ' as a delimiter in delimited formatting. Will override --delimit.') do
          if (@formatter != nil) && (@formatter.instance_of? VPCFRDelimitedFormatter)
            @delimiter = ' '
            @formatter.delimiter = @delimiter
          else
            @message = "Error: cannot specify --delimiter unless -f delimit is specified first.\n#{opts}"
            @isGood = false
            @isGood
          end
        end

        opts.on('-i','--awsaccesskeyid id', String,
          'The AWS access key id for S3, defaults to envrionment variable AWS_ACCESS_KEY_ID') do |i|
          @awsAccessKeyID = i
        end

        opts.on('-k','--awssecretaccesskey key', String,
          'The AWS secret access key for S3, defaults to envrionment variable AWS_SECRET_ACCESS_KEY') do |k|
          @awsSecretAccessKey = k
        end

        opts.on('-p','--pattern type', String,
          'The pattern to scan for in the check column, defaults to REJECT') do |p|
          @pattern = p
        end

        opts.on('-s','--source type', [:file],
          'The source type for input data, defaults to file. Allowed: file') do |i|
        end

        opts.on('-r','--awsregion region', String,
          'The AWS region to work in, defaults to envrionment variable AWS_REGION') do |r|
          @awsRegion = r
        end

        opts.on('-x','--regex',String,
          'Flag that signifies that the pattern provided is a ruby regular expression, e.g.: 172\.16\.*  May need to be surrounded by quotes'
          ) do |x|
          @regex = true
        end

        opts.on('-h','--help', String, 'Display program help (this)') do |h|
          @message = opts
          @isGood = false
        end

        opts.on('-v','--version', String,
          'Displays the version number of the application') do |v|
          @message = "VPC Flow Reporter version #{@version}"
          @isGood = false
        end

        opts.on('--raw', String,'Combines -a none -f delimit --space, to output the raw log rows matching the check.') do
          @aggregateCol = 'none'
          @formatter = VPCFRDelimitedFormatter.new(@columnNames)
          @delimiter =  ' '
          @formatter.delimiter = @delimiter
        end
      end

      begin
        parser.parse!(args)
      rescue OptionParser::ParseError => exception
        @message = "#{exception}\n#{parser}"
        @isGood = false
      end

      if @isGood == true
        if @writer == nil
          @writer = VPCFRS3Writer.new(@awsAccessKeyID,
            @awsSecretAccessKey, @awsRegion)
        end

        if @formatter == nil
          @formatter = VPCFRJSONFormatter.new
        end

        if @reader == nil
          @reader = VPCFRFileReader.new(@columnNames)
        end

        if args.length < requiredArgs
          @message = "#{parser}"
          @isGood = false
        else
          @source = args[0]
          if requiredArgs == 2
            @destination = args[1]
          else
            @destination = ''
          end
          @reader.source = @source
          @writer.destination = @destination
          @parser = VPCFRParser.new(@aggregateCol, @checkCol, @pattern, @regex)
        end
      end
    end

    # Simple function to return if the object is a a good, or valid, state.
    # object with the correct configuration.
    #
    # @return [Boolean] value of the isGood instance variable.
    def isGood?
      @isGood
    end
  end
end
