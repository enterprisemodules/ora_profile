require_relative '../spec_helper_acceptance'


describe 'ora_profile::client' do

    context 'when applying Oracle Client 19.0.0.0' do
      it_should_behave_like "a client installer",
          version: '19.0.0.0',
          from: '/software',
          file: 'LINUX.X64_193000_client.zip'
    end

    context 'when applying Oracle Client 18.0.0.0' do
      it_should_behave_like "a client installer",
          version: '18.0.0.0',
          from: '/software',
          file: 'LINUX.X64_180000_client.zip'
      end

    context 'when applying Oracle Client 12.2.0.1' do
      it_should_behave_like "a client installer",
          version: '12.2.0.1',
          from: '/software',
          file: 'linuxx64_12201_client.zip'
      end

    context 'when applying Oracle Client 12.1.0.2', :older_version do
      it_should_behave_like "a client installer",
          version: '12.1.0.2',
          from: '/software',
          file: 'linuxamd64_12102_client.zip'
      end
    

end
