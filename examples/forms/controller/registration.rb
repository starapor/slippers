class RegistrationController < Controller

  def initialize
    @registrationRepository = RegistrationRepository.new
    @registrationValidator = RegistrationValidator.new
  end
  def index
    key = request[:key]
    @form =  @registrationRepository.find(key)
    @message = flash[:message] if flash[:message]
  end
  
  def save
    key=request[:key]    
    form = @registrationRepository.find(key)
    form.update(:name => request[:name], :address => request[:address], :email => request[:email], :phone => request[:phone])
    
    @registrationValidator.validate(form)
    
    @registrationRepository.save(form)
    flash[:message] = "Saved!"
    redirect R('/registration', :index, :key=>form[:key])
  end
end