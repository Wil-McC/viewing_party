class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.references :user, foreign_key: true
      t.datetime :start_time
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
