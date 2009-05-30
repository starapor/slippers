require File.dirname(__FILE__) + '/spec_helper'

describe RegistrationValidator do
  
  it 'should not be valid if name is missing' do
    form = RegistrationFormBuilder.new.build()
    form.update(:address => "123 blah st", :email => "sarah@me.com")
    
    RegistrationValidator.new.validate(form)
    
    form.is_valid?.should be_false
  end 
  
  it 'should not be valid if email is missing' do
    form = RegistrationFormBuilder.new.build()
    form.update(:address => "123 blah st", :name => "sarah@me.com")
    
    RegistrationValidator.new.validate(form)
    
    form.is_valid?.should be_false
  end 
  
  it 'should not be valid if the provided phone number is not in the correct format' do
    form = RegistrationFormBuilder.new.build()
    form.update(:name => "123 blah st", :email => "sarah@me.com", :phone => "not valid")
    
    RegistrationValidator.new.validate(form)
    
    form.is_valid?.should be_false
  end
  
  it 'should not be valid if the email is in the incorrect format' do
    form = RegistrationFormBuilder.new.build()
    form.update(:name => "123 blah st", :email => "sarah without the at me.com")
    
    RegistrationValidator.new.validate(form)
    
    form.is_valid?.should be_false
    form.errors_for(:email).should be_a_kind_of(Enumerable)
    form.errors_for(:email).size.should eql(1)
    form.errors_for(:email).first.should be_a_kind_of(IncorrectEmailFormatError)
  end

  it 'should be valid if all fields correctly filled in' do
    form = RegistrationFormBuilder.new.build()
    form.update(:name => "sarah", :address => "123 blah st", :email => "sarah@me.com")
    
    RegistrationValidator.new.validate(form)
    
    form.is_valid?.should be_true
  end  
    
end