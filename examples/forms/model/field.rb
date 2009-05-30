class Field
  
  def initialize(key, value)
    @key = key
    @value = value
    @errors = []
  end
  
  def update(value)
    @value = value
  end
  
  def value
    @value
  end
  
  def is?(key)
    @key == key
  end
  
  def is_valid?
    @errors.empty?
  end
  
  def invalid(error)
    @errors << error
  end
  
  def errors
    @errors
  end
  
end