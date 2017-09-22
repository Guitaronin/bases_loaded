require 'bases_loaded/version'
require 'bases_loaded/config'

module BasesLoaded

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    
    def connection_pool
      bases_loaded_connection_class.connection_pool
    end

    def retrieve_connection
      bases_loaded_connection_class.retrieve_connection
    end

    def connected?
      bases_loaded_connection_class.connected?
    end

    def remove_connection(klass = self)
      bases_loaded_connection_class.remove_connection
    end

    def bases_loaded_config
      @bases_loaded_config
    end

    def bases_loaded_base=(bases_loaded_base)
      @bases_loaded_config = BasesLoaded::Config.new(bases_loaded_base)
      self.bases_loaded_connection_class = @bases_loaded_config.connection_class
      @bases_loaded_base = bases_loaded_base
    end

    def bases_loaded_base
      @bases_loaded_base
    end

    def bases_loaded_connection_class=(klass)
      @bases_loaded_connection_class = klass
    end

    def bases_loaded_connection_class
      @bases_loaded_connection_class
    end

  end

end
