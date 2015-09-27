class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.text :descrption
      t.integer :point
      t.references :user, index: true

      t.timestamps
    end
    add_attachment :images, :image
  end
end
