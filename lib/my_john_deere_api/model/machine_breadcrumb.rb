module MyJohnDeereApi
  class Model::MachineBreadcrumb < Model::Base
    attr_reader :speed, :heading, :machine_state, :fuel_level, :point, :event_timestamp

    private

    def map_attributes(record)
      @speed = record['speed']
      @heading = record['heading']
      @machine_state = record['machineState']
      @fuel_level = record['fuelLevel']
      @point = record['point']
      @event_timestamp = record['eventTimestamp']
    end

    def expected_record_type
      'Breadcrumb'
    end
  end
end
