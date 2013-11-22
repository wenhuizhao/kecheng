# -*- encoding : utf-8 -*-
class Role < ActiveRecord::Base
  attr_accessible :name, :en_name
  
  class << self
    def student
      find_by_en_name('student')  
    end
  end
end
