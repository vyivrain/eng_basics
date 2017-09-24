class CreateFibs < ActiveRecord::Migration[5.1]
  def change
    create_table :fibs do |t|
      t.integer :items, array: true, default: []
      t.timestamps
    end
  end
end
