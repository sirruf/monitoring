class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :site, foreign_key: true
      t.string :uuid
      t.boolean :solved, default: false
      t.integer :code
      t.string :message

      t.timestamps
    end
  end
end
