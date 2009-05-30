require File.dirname(__FILE__) + '/spec_helper'

describe RegistrationRepository do
  
  it 'should create a new registration form when the key is unknown' do
    form = RegistrationRepository.new.find()
    form[:name].should eql("")
    form[:address].should eql("")
    form[:email].should eql("")
    #form[:key].should eql(3)
  end  
  
  it 'should save a regsistration form' do
    form = RegistrationFormBuilder.new.build(1)
    form.update(:name => "Sarah")
    RegistrationRepository.new.save(form)
    
    registration =  Registration[:id => form[:key]]
    registration.should_not be_nil
    registration.name.should eql("Sarah")
    
    registration.delete
  end
  
  it 'should find a registration form' do
    registration = Registration.create(:name => "sarah", :email => "sarah@me", :address => "Hi")
    registration.save
    
    form = RegistrationRepository.new.find(registration.id)
    form[:name].should eql("sarah")
    form[:address].should eql("Hi")
    form[:email].should eql("sarah@me")
    form[:key].should eql(registration.id)
    
    registration.delete
  end
  
end