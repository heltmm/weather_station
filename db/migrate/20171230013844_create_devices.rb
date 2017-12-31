class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :location
      t.integer :client_id

      t.timestamps
    end
  end
end
