# -*- encoding : utf-8 -*-
class UploadFile < ActiveRecord::Base
  attr_accessible :exercise_id, :name, :photo
  has_attached_file :photo, :styles => {:thumb => "50x50>"}
  belongs_to :exercise

end
