require 'optparse'
require_relative 'vpcfrJSONFormatter'
require_relative 'vpcfrDelimitedFormatter'
require_relative 'vpcfrFileReader'
require_relative 'vpcfrFileWriter'
require_relative 'vpcfrS3Writer'
require_relative 'vpcfrParser'

module VPCFR
  class VPCFRConfig
    attr_reader :aggregateCol, :awsAccessKeyID, :awsSecretAccessKey, :awsRegion,
      :checkCol, :destination, :writer, :formatter, :parser, :pattern, :source,
      :reader, :version, :columnNames, :delimiter, :message


    def initialize(args)
      @columnNames = ['version','accountid','interfaceid','srcaddr','dstaddr',
        'srcport','dstport','protocol','packets','bytes','start','end',
        'action','logstatus']
      @aggregateColumnNames = ['version','accountid','interfaceid','srcaddr','dstaddr',
        'srcport','dstport','protocol','packets','bytes','start','end',
        'action','logstatus','none']
      @aggregateCol = 'srcaddr'
      @awsAccessKeyID = ENV["AWS_ACCESS_KEY_ID"]
      @awsSecretAccessKey = ENV["AWS_SECRET_ACCESS_KEY"]
      @awsRegion = ENV["AWS_REGION"]
      @checkCol = 'action'
      @delimiter = ','
      @destination = nil
      @writer = nil
      @formatter = nil
      @isGood = true
      @parser = nil
      @pattern = 'REJECT'
      @source = nil
      @reader = nil
      @version = '1.0'
      @message = ''

      parser = OptionParser.new do |opts|

        opts.banner = 'Usage: vpcfr [ options ] source destination'
        opts.on('-a','--aggregate column', @aggregateColumnNames,
          'The column to aggregate on, defaults to srcaddr. Allowed: none, version, accountid, interfaceid, srcaddr, dstaddr, srcport, dstport, protocol, packets, bytes, start, end, action, logstatus.') do |a|
          @aggregateCol = a
        end

        opts.on('-c','--check column', @columnNames,
          'The column to check, defaults to action. Allowed: version, accountid, interfaceid, srcaddr, dstaddr, srcport, dstport, protocol, packets, bytes, start, end, action, logstatus.') do |c|
          @checkCol = c
        end

        opts.on('-d', '--dest type', [:file, :s3],
          'The destination type for report type, defaults to s3. Allowed: file, s3') do |d|
          case
          when d == :file
            @writer = VPCFRFileWriter.new
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
          @writer = VPCFRS3Writer.new
        end

        if @formatter == nil
          @formatter = VPCFRJSONFormatter.new
        end

        if @reader == nil
          @reader = VPCFRFileReader.new(@columnNames)
        end

        if args.length != 2
          @message = "#{parser}"
          @isGood = false
        else
          @source = args[0]
          @destination = args[1]
          @reader.source = @source
          @writer.destination = @destination
          @parser = VPCFRParser.new(@aggregateCol, @checkCol, @pattern)
        end

      end
    end

    def isGood?
      @isGood
    end

  end
end
