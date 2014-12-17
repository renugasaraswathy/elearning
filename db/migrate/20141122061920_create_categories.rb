class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :user
      t.string :name
      t.string :slug,:unique=>true
      t.integer :parent_id
      t.timestamps
    end
  end
end
