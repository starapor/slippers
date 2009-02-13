module Slippers
  class DirectoryNotFoundError < IOError
    
    def initialize(directory_name)
      @directory_name = directory_name
    end

    def to_s
      "Could not find the directory : " + @directory_name
    end

  end
end