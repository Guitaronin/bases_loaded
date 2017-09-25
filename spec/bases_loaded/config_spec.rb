require 'spec_helper'
require 'pp'

RSpec.describe BasesLoaded::Config do
  let(:base_name) { 'testdb' }
  let(:config) { BasesLoaded::Config.new(base_name) }

  describe '#config_name' do
    subject(:config_name) { config.config_name }
    it { should eql 'testdb' }
  end

  describe '#connection_class' do
    let(:connection_class) { config.connection_class }
    it 'dynamically creates a connection class' do
      expect(connection_class.name).to eql 'BasesLoaded::Testdb'
    end

    it 'registers connection class' do
      config.connection_class
      expect(BasesLoaded::Config.connection_classes[base_name]).to be connection_class
    end

    it 'uses registered class if present' do
      new_config = BasesLoaded::Config.new(base_name)
      expect(new_config.connection_class).to be config.connection_class
    end
  end

end
