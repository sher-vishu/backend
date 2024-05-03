class AiModel < ApplicationRecord
     belongs_to :user, optional: true
     validates :name, presence: true
     attribute :availability, :boolean, default: true

     scope :available, -> { where(availability: true) }

  # New attribute to track user association with unavailable models
     attribute :has_unavailable_models, :boolean, default: false
end
