class RegistrationRepository
  
  def find(key=rand(100))
    form = RegistrationFormBuilder.new.build(key)
    registration = find_registration(key)
    return form unless registration
    update_form(form, registration)
  end
    
  def save(form)
    registration = find_registration(form[:key])
    registration = create_registration unless registration
    update_registration(registration, form)
    registration.save
    form.update(:key => registration.id)
  end

  private
  
    def find_registration(key)
      registration = Registration[:id => key] 
    end
    
    def create_registration
      registration = Registration.new
      registration
    end
    
    def update_form(form, registration)
      form.update(:name => registration.name, :address => registration.address, :email => registration.email)
      form
    end
    
    def update_registration(registration, form)
      registration.name = form[:name]
      registration.address = form[:address]
      registration.email = form[:email]
    end
end