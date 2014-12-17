class CreateInviteCodes < ActiveRecord::Migration
  def change
    create_table :invite_codes do |t|
      t.string :code
      t.integer :max_registrations

      t.timestamps
    end
  end
end
