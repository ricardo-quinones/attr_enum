class CreateWithNils < ActiveRecord::Migration
  def change
    create_table :with_nils do |t|
      t.integer :category

      t.timestamps
    end
  end
end
