class NumberField
  def validate(form, key)
    return unless form[key]
    return if form[key].is_numeric?
    form.invalid(key, NumberFieldError.new)
  end
end

class NumberFieldError
end