# -*- encoding : utf-8 -*-
module CtrlMeths
  def page_objs(objs, num = 30, pa = :page)
    Kaminari.paginate_array(objs).page(params[pa]).per(num)
  end
end