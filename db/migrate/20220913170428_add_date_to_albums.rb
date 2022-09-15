class AddDateToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :date, :date
    add_column :albums, :content, :text
    add_column :videos, :date, :date
    add_column :videos, :content, :text
  end
end
