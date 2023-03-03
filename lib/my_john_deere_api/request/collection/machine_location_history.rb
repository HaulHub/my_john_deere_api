require 'json'

module MyJohnDeereApi::Request
  class Collection::MachineLocationHistory < Collection::Base
    ##
    # The resource path for the first page in the collection

    def resource
      "/platform/machines/#{associations[:machine]}/locationHistory?lastKnown=#{associations[:last_known]}&startDate=#{associations[:start_date]}"
    end

    ##
    # This is the class used to model the data

    def model
      MyJohnDeereApi::Model::MachineLocationHistory
    end
  end
end
