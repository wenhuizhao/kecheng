class ChangePeriodIdForGrades < ActiveRecord::Migration
  def up
    change_column :grades, :period_id, :integer
  end

  def down
    change_column :grades, :period_id, :integer
  end
end
