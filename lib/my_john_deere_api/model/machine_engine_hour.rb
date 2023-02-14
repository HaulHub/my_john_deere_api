module MyJohnDeereApi
  class Model::MachineEngineHour < Model::Base
    attr_reader :reading, :report_time

    private

    def map_attributes(record)
      @reading = record['reading']
      @report_time = record['reportTime']
    end

    def expected_record_type
      'EngineHours'
    end
  end
end
