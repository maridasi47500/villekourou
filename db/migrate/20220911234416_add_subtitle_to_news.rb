class AddSubtitleToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :subtitle, :string
  end
end
