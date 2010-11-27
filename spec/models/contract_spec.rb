require 'spec_helper'

describe Contract do
  
  before(:each) do
    @attr = { :name                  => "Example Contract", 
              :description           => "Example Contract",
	      :alias		     => "foobar"
            }
  end

  it "should create a new instance given valid attributes" do
    Contract.create!(@attr)
  end

  it "should require a name" do
    no_name_contract = Contract.new(@attr.merge(:name => ""))
    no_name_contract.should_not be_valid
  end

  it "should require an alias" do
    no_alias_contract = Contract.new(@attr.merge(:alias => ""))
    no_alias_contract.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = Contract.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  
  it "should reject duplicate alias names" do
    Contract.create!(@attr)
    contract_with_duplicate_alias = Contract.new(@attr)
    contract_with_duplicate_alias.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_alias = @attr[:alias].upcase
    Contract.create!(@attr.merge(:alias => upcased_alias))
    contract_with_duplicate_alias = Contract.new(@attr)
    contract_with_duplicate_alias.should_not be_valid
  end

end

