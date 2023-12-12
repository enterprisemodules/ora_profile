require 'spec_helper'

describe 'ora_profile::level_to_patches' do
  let(:oracle_version) { '19.0.0.0'}
  let(:opatch_version) { '12.2.0.1.28'}
  let(:oracle_home)    { '/oracle_home_1'}
  let(:patch_type)     { 'db'}

  #
  # The my_own_key keys is to verify that all other keys are transported transparently to
  # the resulting resource hash.
  #
  example_db_patch_definition = {
    'APR2019RU' => {
      "29301687-GIRU-12.2.0.1.190416" => {
        'file'               => "p29301687_122010_Linux-x86-64.zip",
        'db_sub_patches'     => ['29314339','29314424'],
        'grid_sub_patches'   => ['29314339','29314424','29301676','26839277','28566910'],
        'required_opversion' => '12.2.0.1.28',
        'my_own_key'         => 12,
      },
      "29314340" => {
        'file'                  => "p29314340_122010_Linux-x86-64.zip",
        'db_sub_patches'        => ['29314340'],
        'grid_sub_patches'      => [],
        'required_opversion'    => '12.2.0.1.28',
        'remove_patches_before' => ['29301686','26229277'],
      }
    },
    'JUL2019RU' => {
      "29708720-GIRU-12.2.0.1.190716" => {
        'file'               => "p29708720_122010_Linux-x86-64.zip",
        'db_sub_patches'     => ['29757449','29770040'],
        'grid_sub_patches'   => ['29770040','29770090','26839277','28566910'],
        'required_opversion' => '12.2.0.1.28',
        'my_own_key'         => 12,
      }
    }
  }

  example_db_patch_result = {
    "/oracle_home_1:29301687-GIRU-12.2.0.1.190416" => {
      "my_own_key"  => 12, 
      "source"      => "/source_dir/p29301687_122010_Linux-x86-64.zip", 
      "sub_patches" => ["29314339", "29314424"]
    },
    "/oracle_home_1:29314340" => {
      "remove_patches_before" => ["29301686", "26229277"],
      "source"                => "/source_dir/p29314340_122010_Linux-x86-64.zip",
      "sub_patches"           => ["29314340"]
    }
  }

  example_grid_patch_result = {
    '/oracle_home_1:29301687-GIRU-12.2.0.1.190416' => {
      'source'      => '/source_dir/p29301687_122010_Linux-x86-64.zip',
      'sub_patches' => ['29314339','29314424','29301676','26839277','28566910'],
      'type'        => 'psu',
      'my_own_key'  => 12,
    }
  }

  example_multi_db_patch_result = {
    '/oracle_home_1:29301687-GIRU-12.2.0.1.190416' => {
      'source'      => '/source_dir/p29301687_122010_Linux-x86-64.zip',
      'sub_patches' => ['29314339','29314424'],
      'my_own_key'  => 12,
    },
    "/oracle_home_1:29314340" => {
      "remove_patches_before" => ["29301686", "26229277"],
      "source"                => "/source_dir/p29314340_122010_Linux-x86-64.zip",
      "sub_patches"           => ["29314340"]
    },
    '/oracle_home_2:29708720-GIRU-12.2.0.1.190716' => {
      'source'      => '/source_dir/p29708720_122010_Linux-x86-64.zip',
      'sub_patches' => ['29757449','29770040'],
      'my_own_key'  => 12,
    }
  }

  example_multi_grid_patch_result = {
    '/oracle_home_1:29301687-GIRU-12.2.0.1.190416' => {
      'source'      => '/source_dir/p29301687_122010_Linux-x86-64.zip',
      'sub_patches' => ['29314339','29314424','29301676','26839277','28566910'],
      'my_own_key'  => 12,
      'type'        => 'psu',
    },
    '/oracle_home_2:29708720-GIRU-12.2.0.1.190716' => {
      'source'      => '/source_dir/p29708720_122010_Linux-x86-64.zip',
      'sub_patches' => ['29770040','29770090','26839277','28566910'],
      'my_own_key'  => 12,
      'type'        => 'psu',
    }
  }

  example_ojvm_patch_definition = {
    'APR2019RU' => {
      "/oracle_home_in_data:29249637-OJVM-12.2.0.1.190416" => {
        'source'      => "/source_dir/p29249637_122010_Linux-x86-64.zip",
        'sub_patches' => ['29249637'],
      }
    },
    'JUL2019RU' => {
      "/oracle_home_in_data:29774415-OJVM-12.2.0.1.190716" => {
        'source'      => "/source_dir/p29774415_122010_Linux-x86-64.zipp",
        'sub_patches' => ['29774415'],
      }
    }
  }

  example_ojvm_patch_result = {
    "/oracle_home_1:29249637-OJVM-12.2.0.1.190416" => {
      'source'      => "/source_dir/p29249637_122010_Linux-x86-64.zip",
      'sub_patches' => ['29249637'],
    }
  }

  context "Patch level is a string" do
    let(:params) {
      [
        'APR2019RU',
        '/source_dir',
        opatch_version,
        oracle_home,
        oracle_version,
        patch_type
      ]
    }

    context "No valid oracle home specified" do
      let(:oracle_home) {}
      it "Reports an invalid home" do
        is_expected.to run.with_params(*params).and_raise_error(/Invalid oracle_home specified/) 
      end
    end

    context "Level is NONE" do
      let(:params) {
        [
          'NONE',
          '/source_dir',
          opatch_version,
          oracle_home,
          oracle_version,
          patch_type
        ]
      }
  
      it "Returns an empty hash" do
        is_expected.to run.with_params(*params).and_return({})
      end
    end

    context "Level not found" do
      before do
        allow(subject.func).to receive(:db_patch_levels).and_return({'19.0.0.0' => {}})
      end

      it "Reports an invalid level" do
        is_expected.to run.with_params(*params).and_raise_error(/Level 'APR2019RU' not defined for Oracle version/) 
      end
    end

    context "db patches" do
      let(:patch_type) { 'db'}

      context "Level found" do
        before do
          allow(subject.func).to receive(:db_patch_levels).and_return({'19.0.0.0' => example_db_patch_definition})
        end

        it "Returns the specfied hash" do
          is_expected.to run.with_params(*params).and_return(example_db_patch_result) 
        end
      end
    end

    context "grid patches" do
      let(:patch_type) { 'grid'}

      context "Level found" do
        before do
          allow(subject.func).to receive(:db_patch_levels).and_return({'19.0.0.0' => example_db_patch_definition})
        end

        it "Returns the specfied hash" do
          is_expected.to run.with_params(*params).and_return(example_grid_patch_result) 
        end
      end
    end

    context "ojvm patches" do
      let(:patch_type) { 'ojvm'}

      context "Level found" do
        before do
          allow(subject.func).to receive(:ojvm_patch_levels).and_return({'19.0.0.0' => example_ojvm_patch_definition})
        end

        it "Returns the specfied hash" do
          is_expected.to run.with_params(*params).and_return(example_ojvm_patch_result) 
        end
      end
    end

  end

  context "Patch level is a Hash" do
    before do
      allow(subject.func).to receive(:db_version).and_return('19.0.0.0')
    end

    let(:params) {
      [
        {
          'HOME_1' => {
            'oracle_home' => '/oracle_home_1',
            'level'       => 'APR2019RU',
            'version'     => '19.0.0.0'
          },
          'HOME_2' => {
            'oracle_home' => '/oracle_home_2',
            'level'       => 'JUL2019RU',
            'version'     => '19.0.0.0'
          }
        },
        '/source_dir',
        opatch_version,
        nil,
        nil,
        patch_type
      ]
    }

    context "An oracle home is specified" do
      let(:oracle_home) { '/home'}
      # Don't check this
    end

    context "Level is NONE" do
      let(:params) {
        [
          {'HOME_1' => {
            'oracle_home' => '/oracle_home_1',
            'level'       => 'NONE'
            }
          },
          '/source_dir',
          opatch_version,
          nil,
          nil,
          patch_type
        ]
      }
  
      it "Returns an empty hash" do
        is_expected.to run.with_params(*params).and_return({})
      end
    end

    context "Level not found" do

      before do
        allow(subject.func).to receive(:db_patch_levels).and_return({'19.0.0.0' => {}})
      end

      it "Reports an invalid level" do
        is_expected.to run.with_params(*params).and_raise_error(/Level 'APR2019RU' not defined for Oracle version/) 
      end
    end

    context 'patch type is db' do
      context "Level found" do
        before do
          allow(subject.func).to receive(:db_patch_levels).and_return({'19.0.0.0' => example_db_patch_definition})
        end

        it "Returns the specfied hash" do
          is_expected.to run.with_params(*params).and_return(example_multi_db_patch_result) 
        end

      end
    end

    context 'patch type is grid' do
      let(:patch_type) {'grid'}
      context "Level found" do
        before do
          allow(subject.func).to receive(:db_patch_levels).and_return({'19.0.0.0' => example_db_patch_definition})
        end

        it "Returns the specfied hash" do
          is_expected.to run.with_params(*params).and_return(example_multi_grid_patch_result) 
        end

      end
    end
  end
end




