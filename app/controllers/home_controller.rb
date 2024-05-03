# app/controllers/home_controller.rb
class HomeController < ApplicationController
  before_action :authenticate_user!
  layout :choose_layout

  def index
    @current_admin = current_user
    @ai_models = current_user.admin? ? AiModel.all : current_user.ai_models
  end

  private

  def choose_layout
    current_user.admin? ? 'admin' : 'user'
  end
end
   