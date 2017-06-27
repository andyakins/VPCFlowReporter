#! /usr/bin/env ruby
#minimal script that does only what the assignment required.
#gets AWS params from environment.
require 'json'
require 'aws-sdk'
require 'uri'

uri = URI(ENV[1])
data = Hash.new(0)
File.open(ENV[0]) do |file|
  while row = file.gets
    cols = row.split(' ')
    if cols[12] == 'REJECT'
      data[cols[3]] +=1
    end
  end
end
s3 = Aws::S3::Resource.new(region: ENV["AWS_REGION"],
  credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"],
    ENV["AWS_SECRET_ACCESS_KEY"])
obj = s3.bucket(uri.host).object(uri.path[1..-1])
obj.put(body: JSON.pretty_generate(data))
