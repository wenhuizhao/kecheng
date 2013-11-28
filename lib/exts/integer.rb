# -*- encoding : utf-8 -*-
class Integer
  def to_cnum
    self < 11 ? App::ChineseNum[self] : self
  end
end