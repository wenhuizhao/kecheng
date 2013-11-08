class AddEnjoinToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :enjoin, :string
  end
end
