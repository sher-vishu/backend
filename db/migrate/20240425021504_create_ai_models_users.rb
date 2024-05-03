class CreateAiModelsUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_models_users do |t|
      t.references :ai_model, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
