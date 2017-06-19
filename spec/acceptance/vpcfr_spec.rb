require_relative '../../app/vpcfrRunner.rb'

module VPCFR
  RSpec.describe 'A correct configuration' do
    source = 'data/sample.dat'
    destination = 'data/acceptance.out'

    it 'can run  and produce an output file' do
      if File.exist?(destination)
        FileUtils.rm(destination)
      end
      runner = VPCFRRunner.new
      count = runner.run(['-d','file',source,destination])
      expect(FileUtils.compare_file(destination,'data/acceptNorm.dat')).to eq(true)
    end

    it 'can run in raw mode and produce an output file' do
      if File.exist?(destination)
        FileUtils.rm(destination)
      end
      runner = VPCFRRunner.new
      count = runner.run(['--raw','-d','file',source,destination])
      expect(count).to eq(19)
      expect(File.exist?(destination)).to eq(true)
      expect(FileUtils.compare_file(destination,'data/acceptRaw.dat')).to eq(true)
    end
  end
end
