class ChangePeriodToPeriodIdForGrades < ActiveRecord::Migration
  def up
    rename_column :grades, :period, :period_id
    add_index :grades, :period_id
  end

  def down
    rename_column :grades, :period_id, :period
  end
end
