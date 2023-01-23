require 'json'

module MyJohnDeereApi::Request
  class Collection::MachineEngineHours < Collection::Base
    ##
    # The resource path for the first page in the collection

    def resource
      "/platform/machines/#{associations[:machine]}/engineHours?lastKnown=#{associations[:last_known]}&startDate=#{associations[:start_date]}"
    end

    ##
    # This is the class used to model the data

    def model
      MyJohnDeereApi::Model::MachineEngineHour
    end
  end
end
