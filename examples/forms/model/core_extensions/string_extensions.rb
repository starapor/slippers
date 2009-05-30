class String
  def is_numeric?
    true if Float(object) rescue false
  end
end