# -*- encoding : utf-8 -*-
class ChangeColumnForHomework < ActiveRecord::Migration
  def up
    rename_column :homeworks, :lession_id, :lesson_id
  end

  def down
    rename_column :homeworks, :lesson_id, :lession_id
  end
end
