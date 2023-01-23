module MyJohnDeereApi
  class Model::MachineHoursOfOperation < Model::Base
    attr_reader :start_date, :end_date, :engine_state

    private

    def map_attributes(record)
      @start_date = record['startDate']
      @end_date = record['endDate']
      @engine_state = record['engineState']
    end

    def expected_record_type
      'HoursOfOperation'
    end
  end
end
