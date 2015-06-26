class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :avatar
      t.boolean :admin
      t.boolean :activated
      t.string :activation_digest
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :activated_at
      t.datetime :reset_at

      t.timestamps null: false
    end
  end
end
