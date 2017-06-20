require 'rubygems'
require 'bundler/setup'
require 'aws-sdk'
require 'uri'
require_relative 'vpcfrWriter'

module VPCFR

  # Implementation class of the VPCFRWriter template, intended to write a
  # formatted string of data to an S3 bucket as a object.
  #
  # This writer requires proper AWS credentials and region configuration to
  # function properly. Those items can be provided via environment variables
  # or passed on the command line. In either case, the VPCFRConfig object
  # will ensure the values are passed to this writer.
  #
  # Uses the standard AWS SDK for Ruby.
  #
  # @todo Add more error handling
  # @author Andy Akins
  # @since 1.0.0
  class VPCFRS3Writer
    include VPCFRWriter

    attr_reader :bucket, :key

    # Constructor that sets the necessary AWS configuration variables.
    #
    #@param [String] awsAccessKeyID value of the AWS account's AWS_ACCESS_KEY_ID with access to the bucket
    #@param [String] awsSecretAccessKey value of the AWS account's AWS_SECRET_ACCESS_KEY with access to the bucket
    #@param [String] awsRegion value of the AWS region where the bucket is located
    def initialize(awsAccessKeyID, awsSecretAccessKey, awsRegion)
        @awsAccessKeyID = awsAccessKeyID
        @awsSecretAccessKey = awsSecretAccessKey
        @awsRegion = awsRegion
    end

    # Override of the destination setter, to parse the URI given into bucket name and key
    #
    #@param [String] destination URI of the destination bucket and object, like s3://bucket/object.txt
    def destination=(destination)
      @destination = destination
      uri = URI(destination)
      @bucket = uri.host
      @key = uri.path[1..-1]
    end

    # Writes the given String to the S3 bucket.
    #
    #@param [String] data Data to be sent to AWS S3.
    def write(data)
      s3 = Aws::S3::Resource.new(region: @awsRegion,
        credentials: Aws::Credentials.new(@awsAccessKeyID,
          @awsSecretAccessKey))
      obj = s3.bucket(@bucket).object(@key)
      obj.put(body: data)
    end
  end
end
