# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.string :description, null: false
      t.string :youtube_url, null: false

      t.timestamps
    end
  end
end
