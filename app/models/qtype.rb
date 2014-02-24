# -*- encoding : utf-8 -*-
class Qtype < ActiveRecord::Base
  attr_accessible :name
  has_many :exercise
end
