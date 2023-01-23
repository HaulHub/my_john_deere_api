require 'support/helper'

describe 'MyJohnDeereApi::Validators' do
  describe 'loading dependencies' do
    it 'loads Validators::Base' do
      assert JD::Validators::Base
    end

    it 'loads Validators::Machine' do
      assert JD::Validators::Machine
    end

    it 'loads Validators::MachineEngineHour' do
      assert JD::Validators::MachineEngineHour
    end

    it 'loads Validators::MachineDeviceStateReport' do
      assert JD::Validators::MachineDeviceStateReport
    end

    it 'loads Validators::MachineHoursOfOperation' do
      assert JD::Validators::MachineHoursOfOperation
    end

    it 'loads Validators::MachineBreadcrumb' do
      assert JD::Validators::MachineBreadcrumb
    end

    it 'loads Validators::Asset' do
      assert JD::Validators::Asset
    end

    it 'loads Validators::AssetLocation' do
      assert JD::Validators::AssetLocation
    end
  end
end
