# VPCFlowReporter
Simple app to take a VPC Flow log file and produce a report on its contents.

QUICKSTART
  This software was developed using Ruby 2.4.1 on OS X 10.12. It requires
  the bundler gem.

  1. If you do not have ruby installed, visit www.ruby-lang.org to obtain
     an appropriate version for your platform. The code was written using
     ruby 2.4 - it may work with other versions as well (particularly newer
     ones).

  2. If not installed, install bundler:

         gem install bundler

  3. Move into the project directory and use bundler to install necessary gems:

         bundle install --standalone --binstubs

  4. In order to send data to Amazon Web Services (AWS) Simple Storage Services
     (S3) you need an Access Key ID, a Secret Access Key, and an AWS Region.
     All of these are from your AWS account. You must either:
     a) set the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_REGION
        environment variables in your OS to the correct values.
     b) Pass the Access Key ID, Secret Access Key, and Region as command line
        parameters (see below)

  5. The program is run from the bin/vpcfr.rb script. However, if on Unix
     a shell script is provided in the root of the project. For the simplest
     execution, which will process a VPC flow log file and upload a report to
     S3 in JSON format which contains the number of REJECTS found in the file
     aggregating the counts on the source adddress, call either script and
     and pass the filename and the S3 bucket URI:

         bin/vpcfr.rb a_vpc_logfile s3://a_bucket_name/a_object_name

     or, on Unix, simply

         ./vpcfr a_vpc_logfile s3://a_bucket_name/a_object_name

     If you need a file to try, there is a flow log file at:

         data/sample.dat

     Do not alter this data file, as it will break the acceptance tests. A
     simple way to see what this program does, without involving AWS, is:

         ./vpcfr -d stdout data/sample.dat

     which will run the program and display the report to STDOUT, as opposed
     to sending it to S3.

  6. If you wish to run the integration, and acceptance tests, you must
     first edit the data/vpcfrTestData.rb file and add your AWS credential and
     region information to the variables at the top of the file. Failure to do
     this will cause the integration and acceptance tests to fail. The unit
     tests will run properly without AWS credentials. To run all the tests:

         bin/rspec

     If you do not set the AWS credentials and region information rspec will
     report two (2) errors. These are the acceptance test and the S3
     integration test.

  7. If you wish to generate program documentation, simply use the yard tool:

         bin/yard

     The documentation will be generated as html, with the document root at:

         doc/index.html

DETAILED USEAGE

  vpcfr has a good number of command line arguments that can be passed to change
  its behavior:

  -a, --aggregate <column name>
    Changes the column that the data is aggregated on. Defaults to srcaddr.
    There is a special column name for aggregation called none - this 'column'
    prevents aggregation and instead will cause each matching row to be
    dumped as opposed to a count of matches based on aggregation column being
    built up.

  -c, --check <column name>
    Changes the column that the pattern is checked against. Defaults to action.

  -d, --destination <destination type>
    Changes the output destination type. Defaults to s3. The other acceptable
    types are file and stdout. With the file type, the s3 URI is replaced by
    a filename, and the output will be written to that file. With stdout, the
    destination name is optional (and ignored if present) and the output is
    written to the shell's standard output (usually the screen). This can
    be useful if you wish the output of the script to be piped to another
    program/script.

  -f, --format <format type>
      --delimiter <delimiter>
      --space
    Changes the output format of the report. Defaults to json. The other
    acceptable format is csv. If csv is selected, you can also included either
    the --delimiter or --space flags. --delimiter allows you to specify the
    column delimiter (defaults to comma), where --space sets the delimiter to
    a space.

  -i, --awsaccesskeyid <aws access key id>
    Passes the AWS access key id from the command line, as opposed to grabbing
    it from the environment.

  -k, --awssecretaccesskey
    Passes the AWS secret access key from the command line, as opposed to
    grabbing it from the environment.

  -p, --pattern <pattern text>
    Changes the pattern that the script searches for on the check column.
    Defaults to REJECT. If the -x or --regex flag has been passed, match
    processing will be handled as a regular expression, e.g.: 172\.16\.*
    performed on the srcaddr column would match on all source addresses in
    the 172.16.0.0 subnet. If the -x or --regex flag has not been passed,
    the pattern must match the data exactly.

  -s, --source
    Changes the input source type. Flag is present for future expansion,
    currently the only allowed value is file.

  -r, --awsregion
    Passes the AWS region from the command line, as opposed to grabbing it
    from the environment.

  -x, --regex
    Sets the pattern matching to be based on regular expressions as opposed to
    a straight string comparison. See -p,--pattern for more details.

  -h, --help
    Displays the usage of the script, and lists all possible options/flags.

  -v, --version
    Displays the program version.

  --raw
    Shortcut for "-a none -f csv --space". This will cause no aggregation to
    occur and for the records to be outputted in a CSV format with space
    delimiter. Basically, it will dump all rows that match the pattern
    in native VPC Flog Log format (space separated columns). For example,
    if you wanted to see all the REJECT records to evaluate them, instead of
    just counting the numbers.

  For the -a,--aggregate and -c,--check options, the following column names
  are accepted:

    version, accountid, interfaceid, srcaddr , dstaddr, srcport, dstport, protocol, packets , bytes, start , end, action, logstatus

  As noted above in the -a,--aggregate description, you can also pass the
  pseudo-column 'none' as the column to aggregate on.

  The script returns, as its exit code, the number of records/rows that
  were produced in the report. This is NOT the same as the counts in an
  aggregate report; for example, if the default report produced two
  source addresses that had 5 and 7 counts respectively, the return code is
  2, not 12.

EXAMPLES

  Count all rejects in a file and group by source address, sending the report
  in json format to s3 (default):

    ./vpcfr input.log s3://a_bucket_name//object_name.json

  Count all rejects in a file and group by source address, saving the report
  locally in json format:

    ./vpcfr -d file input.log output.json

  Count all accepts in a file and group by source address, sending the report
  in json format to s3:

    ./vpcfr -p ACCEPT input.log s3://a_bucket_name//object_name.json

  Count all rejects in a file and group by destination address, sending the
  report in json format to s3:

    ./vpcfr -a dstaddr input.log s3://a_bucket_name//object_name.json

  Dump all rejects in a file, sending the report in json format to s3:

    ./vpcfr -a none input.log s3://a_bucket_name//object_name.json

  Count all rejects in a file and group by source address, sending the report
  in csv format to s3:

    ./vpcfr -f csv input.log s3://a_bucket_name//object_name.json

  Dump all records from subnet 172.16.0.0, sending the report in space  
  space delimited format to s3:

    ./vpcfr --raw -c srcaddr -p '172\\.16\\.\*' -x input.log s3://a_bucket_name//object_name.json

POTENTIAL ENHANCEMENTS
  These are some ideas that I had that would improve the application, but
  have not been implemented:

  * Multiple check columns, allowing to do searches like "find all records
    where action is ACCEPT and srcport is 80". Possible call:

    ./vpcfr -c action,srcport -p ACCEPT,80 input.log s3://bucket/output.json

  * Other source types: ftp/sftp/scp, web service, STDIN.

  * Other destination types: webdav, ftp/sftp/srcport.

  * Converting the script into a rubygem so it can be more easily shared.

  * better error handling, particularly around AWS.

  * behavior around overwriting data. Should the output object/file
    automatically overwrite existing objects/files with the same name,
    or should we require some flag (like --force) to overwrite a file.
    Currently, all data will be overwritten.

  * behavior around the naming of the destination. For example, being able to
    specify a pattern for a destination like <date>-<time>-output.json where
    <date> and <time> are replaced with the actual date and time of the run.
    This could allow the script to be part of an automated process, where the
    report is generated every hour/day/week and then results stored without
    overwriting previous runs.

  * Different pattern matching behaviors, like ranges or specific data
    types like date/time. For example, if you wanted to pull out data from
    the file within a particular timeframe, e.g.: 10am to 12pm. on the
    start column.

DESIGN NOTES

  This script was born out of an assignment given to me to write a
  program/script to read AWS VPC Flow Logs, count up the number of
  REJECTS by source address, and produce JSON output which is then
  written to an AWS S3 bucket.

  Looking at the code, you can see that what I put together is quite a
  bit more than that.

  In doing this assignment, I had to weigh the idea of simply cranking out
  a simple script that did just that task, or write a tool that could do
  that, and more. I obviously chose the later:

  * It showcased my coding practices and style more, which was being
    evaluated.

  * It has much more reuse potential

  * It really didn't take too long to write - a couple days instead of a
    hour or two.

  * This was more fun.

  If you look at the vpcfrFileReader.rb, vpcfrParser.rb, vpcfrJSONFormatter.rb
  and vpcfrS3Writer classes, you can see the general code that would have been
  used if I had chosen to just throw together a one off script.

  I chose Ruby primarily because its my favorite language for coding.
  Professionally I'm more versed in Java and Python, but I prefer Ruby
  and whenever I have the opportunity to use it and improve my skills,
  I'll take it.

  The core of the system is the VPCFRConfig class. It parses the command
  line then constructs the reader, parser, formatter and writer classes that
  do the work. The system is extendible by merely adding new options/choices
  to the VPCFRConfig class and then created the appropriate utility classes.
  This modularity makes for easy testing and extendibility. Everything is
  contained in the VPCFR module, for namespace protection and structure.

  Whenever possible, standard Ruby libraries/gems were used as opposed to
  crafting custom solutions: JSON, aws-sdk, OptionParser.

  I've tested things fairly well both manually and rspec, but obviously
  take appropriate cautions, particularly with the destination - the script
  will happily overwrite existing objects/files.
