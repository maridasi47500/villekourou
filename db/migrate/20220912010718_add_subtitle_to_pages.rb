class AddSubtitleToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :subtitle, :string
  end
end
