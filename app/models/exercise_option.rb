# -*- encoding : utf-8 -*-
class ExerciseOption < ActiveRecord::Base
  OPTION_NUM = ['A', 'B', 'C', 'D', 'E', 'F']
  attr_accessible :exercise_id, :name
  belongs_to :exercise

  def full_name
    index = 0
    exercise.options.each_with_index do |o, i| 
      if exercise.options[i] == self
        index = i
        break
      end
    end
    return '' if name.size == 0
    name =~ /^\s*[A-F][\s,\.。、，]+/ ? name : "#{OPTION_NUM[index]}#{name =~ /^[,\.。、，]+/ ? "" : ". "}#{name}"
  end
end
