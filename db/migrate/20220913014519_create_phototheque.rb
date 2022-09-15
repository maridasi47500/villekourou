class CreatePhototheque < ActiveRecord::Migration[6.0]
  def change
    create_table :photocats do |t|
	t.string :title
	t.string :url

	t.timestamps
    end
    create_table :videocats do |t|
	t.string :title
	t.string :url

	t.timestamps
    end
    create_table :videoshavevideocats do |t|
	t.integer :video_id
	t.integer :videocat_id
	end
    create_table :albumshavephotocats do |t|
	t.integer :album_id
	t.integer :photocat_id
	end
    create_table :albums do |t|
	t.string :title
	t.string :url

	t.timestamps
    end
    create_table :photos do |t|
	t.integer :album_id
	t.string :title
	t.string :url

	t.timestamps
    end
    create_table :videos do |t|
	t.string :title
	t.string :url

	t.timestamps
    end
  end
end
