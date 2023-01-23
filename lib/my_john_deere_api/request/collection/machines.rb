require 'json'

module MyJohnDeereApi::Request
  class Collection::Machines < Collection::Base
    ##
    # The resource path for the first page in the collection

    def resource
      "/platform/organizations/#{associations[:organization]}/machines"
    end

    ##
    # This is the class used to model the data

    def model
      MyJohnDeereApi::Model::Machine
    end

    ##
    # Retrieve a machine from JD

    def find(machine_id)
      Individual::Machine.new(client, machine_id).object
    end
  end
end
