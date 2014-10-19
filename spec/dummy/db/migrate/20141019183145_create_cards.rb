class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :suit

      t.timestamps
    end
  end
end
