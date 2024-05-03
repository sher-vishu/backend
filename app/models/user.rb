class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ai_models

  def role
    self.admin? ? 'Admin' : 'User'
  end

   # New attribute to track user association with unavailable models
   attribute :has_unavailable_models, :boolean, default: false

   # Method to update has_unavailable_models flag
   def update_unavailable_models_flag
     self.has_unavailable_models = ai_models.any? { |model| !model.available? }
     save
   end
end
