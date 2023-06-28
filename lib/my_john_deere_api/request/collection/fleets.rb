require 'json'

module MyJohnDeereApi::Request
  class Collection::Fleets < Collection::Base
    ##
    # The resource path for the first page in the collection

    def resource
      "/Fleet/#{associations[:page_number]}"
    end

    ##
    # This is the class used to model the data

    def model
      MyJohnDeereApi::Model::Fleet
    end

    def count
      if next_page = first_page.values[0]['Links'].detect{|link| link['rel'] == 'next'}
        last_page = first_page.values[0]['Links'].detect{|link| link['rel'] == 'last'}
        # example: /Fleet/10
        last_page_number = uri_path(last_page['href']).spit("/").last
        # NOTE: assuming the last page is full
        Integer(last_page_number) * 100
      else
        # TODO: how to count items from the page
        1
      end
    end

    private

    def add_items_from_page(page)
      # TODO: add support for multiple equipments
      @items += [model.new(client, page.values[0]["Equipment"])]
    end

    def set_next_page(page)
      if next_page = page.values[0]['Links'].detect{|link| link['rel'] == 'next'}
        @next_page = uri_path(next_page['href'])
      else
        @next_page = nil
      end
    end
  end
end
