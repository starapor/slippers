class Renderer 
  def initialize(template, subgroups={})
    @template = template
    @subgroups = subgroups
    @attributes = {}
  end
  
  def to_s
    @template.replace_with(@attributes, @subgroups)
  end
  
  def []=(attribute, value)
    @attributes[attribute] = value
  end
end