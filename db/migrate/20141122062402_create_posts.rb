class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :category
      t.references :user
      t.string :title
      t.text :description
      t.integer :published
      t.integer :views
      t.string :slug,:unique=>true
      t.timestamps
    end
  end
end
