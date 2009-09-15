class AgeRenderer
  def render(date)
    age = DateTime.now.year - date.year
    age.to_s
  end
end