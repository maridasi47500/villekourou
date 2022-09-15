class CreateOthervideos < ActiveRecord::Migration[6.0]
  def change
    create_table :othervideos do |t|
      t.integer :videoa_id
      t.integer :videob_id
    end
  end
end
