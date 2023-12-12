require 'spec_helper'

describe 'ora_profile::level_to_bundle' do
  let(:oracle_version) { '19.0.0.0'}
  let(:oracle_home)    { '/oracle_home_1'}

  example_db_patch_definition = {
    'APR2019RU' => {
      "29301687-GIRU-12.2.0.1.190416" => {
        'file'             => "p29301687_122010_Linux-x86-64.zip",
        'db_sub_patches'   => ['29314339','29314424'],
        'grid_sub_patches' => ['29314339','29314424','29301676','26839277','28566910'],
        'my_own_key'       => 12,
      }
    },
    'JUL2019RU' => {
      "29708720-GIRU-12.2.0.1.190716" => {
        'file'             => "p29708720_122010_Linux-x86-64.zip",
        'db_sub_patches'   => ['29757449','29770040'],
        'grid_sub_patches' => ['29770040','29770090','26839277','28566910'],
        'my_own_key'       => 12,
      }
    }
  }

  context "Patch level is a string" do

    context "Level is NONE" do
      let(:params) {
        [
          'NONE',
          '19.0.0.0'
        ]
      }
  
      it "Returns an 'n/a'" do
        is_expected.to run.with_params(*params).and_return('n/a')
      end
    end


    context "Level found" do
      before do
        allow(subject.func).to receive(:db_patch_levels).and_return({'19.0.0.0' => example_db_patch_definition})
      end

      let(:params) {
        [
          'APR2019RU',
          '19.0.0.0'
        ]
      }

      it "Returns the specified patch bundle" do
        is_expected.to run.with_params(*params).and_return('29301687-GIRU-12.2.0.1.190416') 
      end
    end
  end
end




