class Exercise < ActiveRecord::Base
  attr_accessible :answer, :note, :title, :photo, :book_id, :category_id
  has_attached_file :photo
  belongs_to :book
  belongs_to :category
  has_and_belongs_to_many :homeworks
end
