module MyJohnDeereApi::Validators
  autoload :Base,                     'my_john_deere_api/validators/base'
  autoload :Machine,                  'my_john_deere_api/validators/machine'
  autoload :MachineEngineHour,        'my_john_deere_api/validators/machine_engine_hour'
  autoload :MachineDeviceStateReport, 'my_john_deere_api/validators/machine_device_state_report'
  autoload :MachineHoursOfOperation,  'my_john_deere_api/validators/machine_hours_of_operation'
  autoload :MachineBreadcrumb,        'my_john_deere_api/validators/machine_breadcrumb'
  autoload :MachineLocationHistory,   'my_john_deere_api/validators/machine_location_history'
  autoload :Asset,                    'my_john_deere_api/validators/asset'
  autoload :AssetLocation,            'my_john_deere_api/validators/asset_location'
end
