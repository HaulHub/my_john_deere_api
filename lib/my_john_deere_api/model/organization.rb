require 'uri'

class MyJohnDeereApi::Model::Organization
  attr_reader :name, :type, :id, :links

  def initialize(record)
    @name = record['name']
    @type = record['type']
    @id = record['id']
    @member = record['member']

    @links = {}

    record['links'].each do |association|
      @links[association['rel']] = uri_path(association['uri'])
    end
  end

  def member?
    @member
  end

  private

  def uri_path(uri)
    URI.parse(uri).path.gsub('/platform', '')
  end
end