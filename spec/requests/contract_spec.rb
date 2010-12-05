require 'spec_helper'

describe "Contracts" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new contract" do
        lambda do
          visit new_contract_path
          fill_in :contract_alias, :with => ""
          click_button
          response.should render_template('contracts/index')
          response.should have_selector("div", :content => "Not authorized")
        end.should_not change(Contract, :count)
      end
    end

    describe "success" do

      it "should make a new contract" do
        @user.toggle!(:manager)
        good_alias = "Lorem"
        good_name = "Lorem"
        lambda do
          visit new_contract_path
          fill_in :contract_alias, :with => good_alias
          fill_in :contract_name, :with => good_name
          click_button
          response.should have_selector("div", :content => "successfully created Contract.")
        end.should change(Contract, :count).by(1)
      end
    end
  end
end

