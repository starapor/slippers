require 'template'

module Slippers 
  class FileTemplate  < Template
    def initialize(filename)
      @filename = filename
    end
    attr_reader :filename
    def template()
      return @template if @template
      @template = File.read(@filename)
    end
  end
end