require 'support/helper'

describe 'MyJohnDeereApi::Model' do
  describe 'loading dependencies' do
    it 'loads Model::Base' do
      assert JD::Model::Base
    end

    it 'loads Model::Machine' do
      assert JD::Model::Machine
    end

    it 'loads Model::MachineEngineHour' do
      assert JD::Model::MachineEngineHour
    end

    it 'loads Model::MachineDeviceStateReport' do
      assert JD::Model::MachineDeviceStateReport
    end

    it 'loads Model::MachineHoursOfOperation' do
      assert JD::Model::MachineHoursOfOperation
    end

    it 'loads Model::MachineBreadcrumb' do
      assert JD::Model::MachineBreadcrumb
    end

    it 'loads Model::Asset' do
      assert JD::Model::Asset
    end

    it 'loads Model::AssetLocation' do
      assert JD::Model::AssetLocation
    end

    it 'loads Model::ContributionProduct' do
      assert JD::Model::ContributionProduct
    end

    it 'loads Model::ContributionDefinition' do
      assert JD::Model::ContributionDefinition
    end

    it 'loads Model::Organization' do
      assert JD::Model::Organization
    end

    it 'loads Model::Field' do
      assert JD::Model::Field
    end

    it 'loads Model::Flag' do
      assert JD::Model::Flag
    end
  end
end
