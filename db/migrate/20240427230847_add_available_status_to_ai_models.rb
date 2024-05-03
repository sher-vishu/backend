class AddAvailableStatusToAiModels < ActiveRecord::Migration[7.1]
  def change
    add_column :ai_models, :available_status, :boolean
  end
end
