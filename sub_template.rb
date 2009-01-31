class SubTemplate
  def initialize(template)
    @template = template
  end
  
  def replace_with(object, subgroups)
    @template.gsub(/\$([\w]+)\$/) {|s| object.send($1)}
  end
end