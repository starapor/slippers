class SubTemplate
  def initialize(template)
    @template = template
  end
  
  def replace_with(object, subgroups)
    @template.gsub(/\$([\w]+)\$/) {|s| puts "found the subtemplate attributes"; object.send($1)}
  end
end