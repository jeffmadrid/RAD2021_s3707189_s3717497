class CreateItemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :item_images do |t|
      t.references :item, foreign_key: true
      t.string :image_link

      t.timestamps
    end
  end
end
