class AddStatusToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :status, :string
  end
end
