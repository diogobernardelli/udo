class CreateSetting < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.boolean :alerts, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
