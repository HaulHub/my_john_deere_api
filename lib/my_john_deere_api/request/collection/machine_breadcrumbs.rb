require 'json'

module MyJohnDeereApi::Request
  class Collection::MachineBreadcrumbs < Collection::Base
    ##
    # The resource path for the first page in the collection

    def resource
      "/platform/machines/#{associations[:machine]}/breadcrumbs?lastKnown=#{associations[:last_known]}"
    end

    ##
    # This is the class used to model the data

    def model
      MyJohnDeereApi::Model::MachineBreadcrumb
    end
  end
end
