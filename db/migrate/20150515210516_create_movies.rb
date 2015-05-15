class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.integer :runtime_in_minutes
      t.string :description
      t.string :text
      t.string :poster_immage_url
      t.datetime :release_date

      t.timestamps null: false
    end
  end
end
