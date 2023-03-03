module MyJohnDeereApi
  class Model::MachineLocationHistory < Model::Base
    attr_reader :point, :event_timestamp, :gps_fix_timestamp

    private

    def map_attributes(record)
      @point = record['point']
      @event_timestamp = record['eventTimestamp']
      @gps_fix_timestamp = record['gpsFixTimestamp']
    end

    def expected_record_type
      'ReportedLocation'
    end
  end
end
