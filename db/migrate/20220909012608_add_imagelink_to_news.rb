class AddImagelinkToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :imagelink, :string
    add_column :events, :imagelink, :string
  end
end
