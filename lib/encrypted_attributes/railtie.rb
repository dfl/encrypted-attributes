module EncryptedAttributes
  class Railtie < Rails::Railtie
    config.encrypted_attributes = ActiveSupport::OrderedOptions.new
    config.encrypted_attributes[:key] = nil
    config.encrypted_attributes[:iv]  = nil

    initializer :encrypted_attributes do |app|
      ActiveSupport.on_load :active_record do  # this is so Rails.root won't be nil

        # fetch config vars from config/yml or environment, if none provided already

        path      = Rails.root.join( 'config', 'encrypted_attributes.yml' )
        yml_conf  = File.exist?(path) ? YAML.load( File.open(path) )[ Rails.env ] : {}

        ea_config = app.config.encrypted_attributes
        ea_config[:key] ||= yml_conf['key'] || ENV['ENCRYPTED_ATTRIBUTES_KEY']
        ea_config[:iv]  ||= yml_conf['iv']  || ENV['ENCRYPTED_ATTRIBUTES_IV']

        fail "EncryptedAttributes - key or iv cannot be blank!" if ea_config[:key].blank? || ea_config[:iv].blank?

        EncryptedAttributes.setup( :key => ea_config[:key], :iv => ea_config[:iv] )
      end
    end

  end
end
