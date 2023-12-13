class CreateWeightLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :weight_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :weight
      t.date :log_date
      t.binary :image, limit: 5.megabytes

      t.timestamps
    end
  end
end
