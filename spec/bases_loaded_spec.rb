require "spec_helper"

RSpec.describe BasesLoaded do

  class FakeModel
    include BasesLoaded
  end

  before :each do
    FakeModel.bases_loaded_init 'testdb'
  end

  let(:model) { FakeModel }
  let(:config) { model.bases_loaded_config }

  it "has a version number" do
    expect(BasesLoaded::VERSION).not_to be nil
  end

  describe '.bases_loaded_init' do
    it 'sets bases_loaded_base' do
      model.bases_loaded_init 'foo'
      expect(model.bases_loaded_base).to eql 'foo'
    end
  end

  describe '.bases_loaded_config' do
    it 'is an instance of BasesLoaded::Config' do
      expect(model.bases_loaded_config).to be_instance_of(BasesLoaded::Config)
    end
  end

  describe '.bases_loaded_connection_class' do
    subject(:klass) { model.bases_loaded_connection_class }
    it 'is config connection_class' do
      expect(klass).to be config.connection_class
    end
  end

  describe 'ActiveRecord::Base methods overrides' do
    let(:connection_class) { double }
    let(:model) do
      FakeModel.tap do |m|
        var = :@bases_loaded_connection_class
        m.instance_variable_set(var, connection_class)
      end
    end
    describe '.connection_pool' do
      it 'uses bases_loaded_connection_class' do
        expect(connection_class).to receive(:connection_pool)
        model.connection_pool
      end
    end

    describe '.retrieve_connection' do
      it 'uses bases_loaded_connection_class' do
        expect(connection_class).to receive(:retrieve_connection)
        model.retrieve_connection
      end
    end

    describe '.retrieve_connection' do
      it 'uses bases_loaded_connection_class' do
        expect(connection_class).to receive(:connected?)
        model.connected?
      end
    end

    describe '.remove_connection' do
      it 'uses bases_loaded_connection_class' do
        expect(connection_class).to receive(:remove_connection)
        model.remove_connection
      end
    end

  end

end
