module SpreeReuseCreditCard
  class Engine < Rails::Engine
    engine_name 'spree_reuse_credit_card'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      # Yeah, I know.  Probably wrong place for this
      # There are problems putting it in other places as well
      # (re-educate me if I'm thoroughly confused (which I am))
      Spree::Config.set(:auto_capture => true) rescue nil

      Ability.register_ability(CreditCardAbility)
    end

    config.to_prepare &method(:activate).to_proc
  end
end
