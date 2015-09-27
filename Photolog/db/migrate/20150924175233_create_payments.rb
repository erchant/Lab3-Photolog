class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.text :comment
      t.integer :day
      t.string :state, default: 'Enviado'
      t.references :user, index: true

      t.timestamps
    end
    add_attachment :payments, :image
  end
end
