class RegistrationFormBuilder
  
  def build(key=nil)
    Form.new(:key => key, :name => "", :address => "", :email => "", :phone => nil)
  end

end