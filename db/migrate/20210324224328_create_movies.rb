class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :api_id, index: {unique: true}

      t.timestamps
    end
  end
end
