# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  attr_accessible :name
  DISPLAY_ORDER=['目标聚焦','新课导入','初读点拨','实践应用','精要交流','达标检测','矫错锦囊','指引问答','拓展延伸','其他']
  def self.display_order ids
    DISPLAY_ORDER.map{|n| Category.find_by_name(n).id if ids.include?(Category.find_by_name(n).id)}.reject{|i| i.nil?}
  end
  def self.JingYaoJiaoLiu
    Category.find_by_name('精要交流')
  end
  def self.ChuDuDianBo
    Category.find_by_name('初读点拨')
  end
end
