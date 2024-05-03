class CreateAiModels < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_models do |t|
      t.string :name
      t.boolean :availability

      t.timestamps
    end
  end
end
