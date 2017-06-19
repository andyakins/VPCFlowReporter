require 'rubygems'
require 'bundler/setup'
require 'aws-sdk'
require 'uri'
require_relative 'vpcfrWriter'


module VPCFR
  class VPCFRS3Writer < VPCFRWriter

    attr_reader :bucket, :key

    def initialize(awsAccessKeyID, awsSecretAccessKey, awsRegion)
        @awsAccessKeyID = awsAccessKeyID
        @awsSecretAccessKey = awsSecretAccessKey
        @awsRegion = awsRegion
    end

    def destination=(destination)
      @destination = destination
      uri = URI(destination)
      @bucket = uri.host
      @key = uri.path[1..-1]
    end

    def write(data)
      s3 = Aws::S3::Resource.new(region: @awsRegion,
        credentials: Aws::Credentials.new(@awsAccessKeyID,
          @awsSecretAccessKey))
      obj = s3.bucket(@bucket).object(@key)
      obj.put(body: data)
    end

  end
end
