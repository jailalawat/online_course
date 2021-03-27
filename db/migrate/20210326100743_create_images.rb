# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.references :resource, polymorphic: true, null: false
      t.boolean :primary, default: false

      t.timestamps
    end
  end
end
