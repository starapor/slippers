class Form
  
  def initialize(key_default_pairs={})
    @fields = []
    key_default_pairs.each {|key,value| @fields << Field.new(key, value)}
  end  
  
  def update(new_values) 
    new_values.each { | key,value | find(key).update(value)}
  end
  
  def [](field)
    find(field).value
  end
  
  def is_valid?
    @fields.all? { |field| field.is_valid? }
  end
  
  def invalid(key, error)
    find(key).invalid(error)
  end
  
  def errors_for(key)
    find(key).errors
  end
  
  private
    
    def find(key)
      @fields.find { | field | field.is?(key)}
    end
end