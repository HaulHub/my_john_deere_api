module MyJohnDeereApi
  class Model::Machine < Model::Base
    attr_reader :name, :vin, :category, :make, :model, :telematics_state

    ##
    # A listing of attributes that can be passed back to John Deere

    def attributes
      {
        id: id,
        name: name,
        vin: vin,
        organization_id: 'placeholder'
      }
    end

    ##
    # device state reports associated with this machine

    def device_state_reports(**kwargs)
      (@device_state_reports ||= {})[kwargs.hash] ||= begin
        Request::Collection::MachineDeviceStateReports.new(client, machine: id, **kwargs)
      end
    end

    ##
    # engine hours associated with this machine

    def engine_hours(**kwargs)
      (@engine_hours ||= {})[kwargs.hash] ||= begin
        Request::Collection::MachineEngineHours.new(client, machine: id, **kwargs)
      end
    end

    ##
    # hours of operation associated with this machine

    def hours_of_operation(**kwargs)
      (@hours_of_operation ||= {})[kwargs.hash] ||= begin
        Request::Collection::MachineHoursOfOperation.new(client, machine: id, **kwargs)
      end
    end

    ##
    # breadcrumbs associated with this machine

    def breadcrumbs(**kwargs)
      (@breadcrumbs ||= {})[kwargs.hash] ||= begin
        Request::Collection::MachineBreadcrumbs.new(client, machine: id, **kwargs)
      end
    end

    def location_history(**kwargs)
      (@location_history ||= {})[kwargs.hash] ||= begin
        Request::Collection::MachineLocationHistory.new(client, machine: id, **kwargs)
      end
    end

    private

    def map_attributes(record)
      @vin = record['vin']
      @name = record['name']
      @category = record['category'] || record['equipmentType']
      @make = record['make'] || record['equipmentMake']
      @model = record['model'] || record['equipmentModel']
      @telematics_state = record['telematicsState']
    end

    def expected_record_type
      'Machine'
    end
  end
end
