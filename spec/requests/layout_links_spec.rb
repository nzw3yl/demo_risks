require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

 
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    visit root_path
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    visit root_path
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    visit root_path
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    visit root_path
    click_link "Sign Up"
    response.should have_selector('title', :content => "Sign up")

  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign in")
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profile")
    end
   
    it "should not have a contracts link" do
          visit root_path
          response.should_not have_selector("a", :href => contracts_path,
                                             :content => "Contracts")
    end

 
     
     it "should have a contracts link if user is a manager" do
          @user.toggle!(:manager)
          visit root_path
          response.should have_selector("a", :href => contracts_path,
                                             :content => "Contracts")
     end

     it "should have a workload link if user is a manager" do
          @user.toggle!(:manager)
          visit root_path
          response.should have_selector("a", :href => contracts_path,
                                             :content => "Workload")
     end

     it "should have a work history link if user is a manager" do
          @user.toggle!(:manager)
          visit root_path
          response.should have_selector("a", :href => contracts_path,
                                             :content => "Work History")
     end

     it "should have a reports link if user is a manager" do
          @user.toggle!(:manager)
          visit root_path
          response.should have_selector("a", :href => contracts_path,
                                             :content => "Reports")
     end

     it "should have a contracts link if user is an administrator" do
          @user.toggle!(:admin)
          visit root_path
          response.should have_selector("a", :href => contracts_path,
                                             :content => "Contracts")
     end

     it "should have a workload link if user is an administrator" do
          @user.toggle!(:admin)
          visit root_path
          response.should have_selector("a", :href => contracts_path,
                                             :content => "Workload")
     end

     it "should have a work history link if user is an administrator" do
          @user.toggle!(:admin)
          visit root_path
          response.should have_selector("a", :href => contracts_path,
                                             :content => "Work History")
     end

     it "should have a reports link if user is an administrator" do
          @user.toggle!(:admin)
          visit root_path
          response.should have_selector("a", :href => contracts_path,
                                             :content => "Reports")
     end

     
  end

end

