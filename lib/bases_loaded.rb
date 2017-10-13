require 'bases_loaded/version'
require 'bases_loaded/config'

module BasesLoaded

  def self.included(base)
    base.extend(ClassMethods)
    # This ensures inheriting classes get the same connection pool.
    old_inherited = base.method(:inherited)
    base.define_singleton_method(:inherited) do |subclass|
      # I don't user .super() here, because other modules using this same
      # trick will collide (e.g. BvDatawarehouse)
      old_inherited.call(subclass)
      subclass.bases_loaded_init(base.bases_loaded_base)
    end
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
      @bases_loaded_config ||= BasesLoaded::Config.new(bases_loaded_base)
    end

    def bases_loaded_base=(bases_loaded_base)
      @bases_loaded_base = bases_loaded_base
    end
    alias_method :bases_loaded_init, :bases_loaded_base=

    def bases_loaded_base
      @bases_loaded_base
    end

    def bases_loaded_connection_class=(connection_class)
      @bases_loaded_connection_class = connection_class
    end

    def bases_loaded_connection_class
      @bases_loaded_connection_class ||= bases_loaded_config.connection_class
    end

  end

end
