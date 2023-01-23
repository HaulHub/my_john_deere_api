require 'json'

module MyJohnDeereApi::Request
  class Individual::Machine < Individual::Base
    ##
    # The resource path for the object

    def resource
      "/platform/machines/#{id}"
    end

    ##
    # This is the class used to model the data

    def model
      MyJohnDeereApi::Model::Machine
    end
  end
end
