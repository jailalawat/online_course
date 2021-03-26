class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :source_id, null: false
      t.float :price, null: false, default: 0.0
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description, null: false
      t.text :short_description
      t.index :slug, unique: true

      t.timestamps
    end
  end
end
