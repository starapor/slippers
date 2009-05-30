class IncorrectEmailFormat
  def validate(form, key)
    return unless form[key]
    return if form[key]['@']
    form.invalid(key, IncorrectEmailFormatError.new)
  end
end


class IncorrectEmailFormatError
end