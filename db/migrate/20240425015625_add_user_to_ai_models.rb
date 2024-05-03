class AddUserToAiModels < ActiveRecord::Migration[7.1]
  def change
    add_reference :ai_models, :user, foreign_key: true, null: true
  end
end
