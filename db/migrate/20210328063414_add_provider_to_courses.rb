class AddProviderToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :provider, :string
  end
end
