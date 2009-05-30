class RegistrationValidator
  
  def initialize
    @rules = {
      :name => [RequiredField.new],
      :email => [RequiredField.new, IncorrectEmailFormat.new],
      :phone => [NumberField.new]
    }
  end
  
  def validate(form)
    @rules.each do |key, rules|
      rules.each { |rule| rule.validate(form, key)}
    end
  end
  
end