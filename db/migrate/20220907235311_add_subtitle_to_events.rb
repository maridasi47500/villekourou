class AddSubtitleToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :subtitle, :string
  end
end
