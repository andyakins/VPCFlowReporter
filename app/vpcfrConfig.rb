require 'optparse'
require_relative 'vpcfrJSONFormatter'
require_relative 'vpcfrFileReader'
require_relative 'vpcfrFileWriter'
require_relative 'vpcfrS3Writer'
require_relative 'vpcfrParser'

module VPCFR

  class VPCFRConfig
    attr_reader :aggregateCol, :awsAccessKeyID, :awsSecretAccessKey, :awsRegion,
      :checkCol, :destination, :writer, :formatter, :parser, :pattern, :source,
      :reader, :version, :columnNames


    def initialize(args)
      @columnNames = [:version,:accountid,:interfaceid,:srcaddr,:dstaddr,:srcport,
        :dstport,:protocol,:packets,:bytes,:start,:end,:action,:logStatus]
      @aggregateCol = 'srcaddr'
      @awsAccessKeyID = ENV["AWS_ACCESS_KEY_ID"]
      @awsSecretAccessKey = ENV["AWS_SECRET_ACCESS_KEY"]
      @awsRegion = ENV["AWS_REGION"]
      @checkCol = 'action'
      @destination = nil
      @writer = nil
      @formatter = nil
      @isGood = true
      @parser = nil
      @pattern = 'REJECT'
      @source = nil
      @reader = nil
      @version = "1.0"

      parser = OptionParser.new do |opts|

        opts.banner = 'Useage: vpcfr [ options ] source destination'
        opts.on('-a','--aggregate column', @columnNames,
          'The column to aggregate on, defaults to srcaddr. Allowed: version, accountid, interfaceid, srcaddr, dstaddr, srcport, dstport, protocol, packets, bytes, start, end, action.') do |a|
          @aggregateCol = a
        end
        opts.on('-c','--check column', @columnNames,
          'The column to check, defaults to action. Allowed: version, accountid, interfaceid, srcaddr, dstaddr, srcport, dstport, protocol, packets, bytes, start, end, action.') do |c|
          @checkCol = c
        end
        opts.on('-d', '--dest type', [:file, :s3],
          'The destination type for report type, defaults to s3. Allowed: file, s3') do |d|
          case
          when d == :file
            @writer = VPCFRFileWriter.new
          end
        end
        opts.on('-f','--format type', [:json],
          'The format to output the report in, defaults to json. Allowed: json') do |f|
        end
        opts.on('-h','--help', String, 'Display program help (this)') do |h|
          puts opts
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
        opts.on('-v','--version', String,
          'Displays the version number of the application') do |v|
          puts "VPC Flow Reporter version #{@version}"
        end
      end

      parser.parse!(args)

      if @writer == nil
        @writer = VPCFRS3Writer.new
      end
      if @formatter == nil
        @formatter = VPCFRJSONFormatter.new
      end
      if @reader == nil
        @reader = VPCFRFileReader.new
      end


      if args.length != 2
        puts parser
        @good = false
      else
        @source = args[0]
        @destination = args[1]
        @reader.source = @source
        @reader.columnNames = @columnNames
        @writer.destination = @destination
        @parser = VPCFRParser.new(@aggregateCol, @checkCol)
      end
    end

    def isGood?
      @isGood
    end
  end
end
