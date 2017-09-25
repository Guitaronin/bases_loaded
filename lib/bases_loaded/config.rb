module BasesLoaded
  class Config
    attr_reader :config_name

    def self.connection_classes
      @@connection_classes ||= {}
    end

    def self.register_connection_class(name, klass)
      connection_classes[name] = klass
    end

    def initialize(config_name)
      @config_name = config_name
    end

    def connection_class
      @connection_class ||= begin
        classes = self.class.connection_classes
        classes[config_name] || new_connection_class
      end
    end

    private

    def params
      environment_configs[env]
    end

    def connection_class_name
      config_name.classify
    end

    def new_connection_class
      Class.new(ActiveRecord::Base).tap do |klass|
        BasesLoaded.const_set(connection_class_name, klass)
        klass.abstract_class = true
        klass.establish_connection(params)
        self.class.register_connection_class(config_name, klass)
      end
    end

    def all_configs
      ActiveRecord::Base.configurations['bases_loaded']
    end

    def environment_configs
      all_configs[config_name]
    end

    def env
      Rails.env
    end

  end
end
