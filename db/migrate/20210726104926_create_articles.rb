class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text "picture"
    end
  end
end
