class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.integer :source_id
      t.datetime :check_in
      t.datetime :check_out
      t.decimal :price
      t.string :guest_name
      t.integer :listing_id
      t.string :status

      t.timestamps
    end

    add_index :reservations, :source_id, unique: true
  end
end
