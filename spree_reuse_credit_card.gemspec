# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_reuse_credit_card'
  s.version     = '1.0.0'
  s.summary     = 'Enables view enhancements for managing multiple previously-used credit cards for Spree'
  s.description = 'Enables view enhancements for managing multiple previously-used credit cards for Spree'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Jeff Squires'
  s.email             = 'jeff.squires@gmail.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  #s.files         = `git ls-files`.split("\n")
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'


  #s.add_dependency 'spree', '~> 1.2.0'

  s.add_development_dependency 'spree_auth_devise', '~> 1.2.0'
  s.add_development_dependency 'capybara', '~> 1.1'
  s.add_development_dependency 'factory_girl_rails', '1.5.0'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.7'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'sass-rails', '~> 3.2'
  s.add_development_dependency 'coffee-rails', '~> 3.2'
end
