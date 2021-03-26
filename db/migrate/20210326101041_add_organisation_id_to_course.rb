# frozen_string_literal: true

class AddOrganisationIdToCourse < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :organisation, null: false, foreign_key: true
  end
end
