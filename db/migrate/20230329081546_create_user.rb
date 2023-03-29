class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, index: { unique: true, name: 'unique_username' }
      t.string :email,  index: { unique: true, name: 'unique_email' }
      t.string :password_digest
      t.integer :role, null: false
      t.timestamps
    end
  end
end
