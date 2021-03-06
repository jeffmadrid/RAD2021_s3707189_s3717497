class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :profile_image
      t.integer :checkouts
      t.boolean :admin

      t.timestamps
    end
  end
end
