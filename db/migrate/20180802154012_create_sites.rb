class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.string :owner_email
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
