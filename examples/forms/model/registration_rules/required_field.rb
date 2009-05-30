class RequiredField
  def validate(form, key)
    return if form[key] and not( form[key].empty?)
    form.invalid(key, RequiredFieldError.new)
  end
end

class RequiredFieldError
end