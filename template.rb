require 'ostruct'
module Slippers 
  class Template
    def initialize(template, subtemplates={})
      @template = template
    end
    attr_reader :template
  end    
end