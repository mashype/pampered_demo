class CreateBlogcomments < ActiveRecord::Migration
  def change
    create_table :blogcomments do |t|
      t.text :body
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :blogpost, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
