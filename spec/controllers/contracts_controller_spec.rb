require 'spec_helper'

describe ContractsController do
  render_views

  describe "GET 'new'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in users" do
       before(:each) do
        @user = test_sign_in(Factory(:user))
       end
     
       it "should be successful" do
        get :new
        response.should be_success
       end

       it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "Contracts")
       end
    end
  end

 describe "GET 'index'" do

    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in users" do
       before(:each) do
        @user = test_sign_in(Factory(:user))
       end
     
       it "should be successful" do
        get :index
        response.should be_success
       end

       it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "Contracts")
       end
    end
 end

 
end
