class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :total_credits, default: 1000
      t.integer :used_credits
      t.string :email
      t.string :card_token
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
