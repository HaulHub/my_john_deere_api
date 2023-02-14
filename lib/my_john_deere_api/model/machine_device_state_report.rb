module MyJohnDeereApi
  class Model::MachineDeviceStateReport < Model::Base
    attr_reader :time, :location, :gps_fix_timestamp, :engine_state

    private

    def map_attributes(record)
      @time = record['time']
      @location = record['location']
      @gps_fix_timestamp = record['gpsFixTimestamp']
      @engine_state = record['engineState']
    end

    def expected_record_type
      'DeviceStateReport'
    end
  end
end
