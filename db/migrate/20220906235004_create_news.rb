class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :url
      t.string :image
      t.text :content
	t.date :date
	t.timestamps
    end
    create_table :news do |t|
      t.string :title
      t.string :url
      t.string :image
      t.text :content
	t.date :date
	t.timestamps
    end
    create_table :newscatshavenews do |t|
	t.integer :news_id
	t.integer :newscat_id
    end
    create_table :newscats do |t|

      t.string :name
	t.string :url
	t.timestamps
    end
######
    create_table :places do |t|
	t.string :name
	t.timestamps
    end
    create_table :managers do |t|
	t.string :name
	t.timestamps
    end
    create_table :events do |t|
      t.string :title
      t.string :url
      t.string :image
      t.text :content
	t.date :date
	t.date :begindate
	t.date :enddate
	t.integer :place_id
	t.integer :manager_id
	t.timestamps
    end
    create_table :eventcatshaveevents do |t|
	t.integer :event_id
	t.integer :eventcat_id
    end
    create_table :eventcats do |t|

      t.string :name
	t.string :url
	t.timestamps
    end
  end
end
