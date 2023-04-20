class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      # 必要なパラメーターは画像のみ、activestoregeで設定

      t.timestamps
    end
  end
end
