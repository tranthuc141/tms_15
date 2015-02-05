class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.boolean :is_supervisor
      t.string :avatar
      t.string :address
      t.date :date_of_join

      t.timestamps
    end
  end
end
