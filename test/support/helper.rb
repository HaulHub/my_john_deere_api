require 'rubygems'
require 'webmock'
require 'dotenv/load'
require 'minitest/autorun'
require 'minitest/reporters'
require 'my_john_deere_api'

require 'support/vcr_setup'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

# shortcut for long module name
JD = MyJohnDeereApi

API_KEY = ENV['API_KEY']
API_SECRET = ENV['API_SECRET']

ACCESS_TOKEN = ENV['ACCESS_TOKEN']
ACCESS_SECRET = ENV['ACCESS_SECRET']

TOKEN_PATTERN = /^[0-9a-z\-]+$/
SECRET_PATTERN = /^[0-9A-Za-z\-+=\/]+$/

CONFIG = VcrSetup.new

class Minitest::Spec
  class << self
    def inherits_from klass
      it "inherits from #{klass}" do
        public_methods = Hash.new([]).merge({
          JD::Request::Create::Base => [:request, :object, :valid?, :validate!],
          JD::Request::Collection::Base => [:each, :all, :count],
        })

        assert_kind_of klass, object

        public_methods[klass].each do |method_name|
          assert object.respond_to?(method_name)
        end
      end
    end
  end

  # Helpers from CONFIG

  def client
    @_client ||= CONFIG.client
  end

  def accessor
    @_accessor ||= VCR.use_cassette('catalog') { client.send(:accessor) }
  end

  def base_url
    @base_url ||= accessor.consumer.site
  end

  def api_key
    CONFIG.api_key
  end

  def api_secret
    CONFIG.api_secret
  end

  def access_token
    CONFIG.access_token
  end

  def access_secret
    CONFIG.access_secret
  end

  def contribution_product_id
    CONFIG.contribution_product_id
  end

  def contribution_definition_id
    CONFIG.contribution_definition_id
  end

  def organization_id
    CONFIG.organization_id
  end

  def asset_id
    CONFIG.asset_id
  end

  def field_id
    CONFIG.field_id
  end

  def verify_code
    CONFIG.verify_code
  end
end