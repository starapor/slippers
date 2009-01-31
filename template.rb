class Template
  def initialize(template)
    @template = template
  end
  
  def replace_with(attributes, subgroups)
    template_without_subgroup = replace_sub_templates(attributes, subgroups)
    replace_attributes(template_without_subgroup, attributes)
  end
  
  def replace_sub_templates(attributes, subgroups)
    @template.gsub(/\$([\w]+):([\w]+)\(\)\$/) {|s| puts "yes";subgroups[$2.to_sym].replace_with(attributes[$1.to_sym], subgroups)}
  end
  
  def replace_attributes(template, attributes)
    template.gsub(/\$([\w]+)\$/) {|s| attributes[$1.to_sym]}
  end
end