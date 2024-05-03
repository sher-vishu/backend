class AdminController < ApplicationController
     before_action :authenticate_admin!
   
     def index
      @current_admin = current_user
      @total_users = User.count
      @total_ai_models = AiModel.count
      @ai_models = AiModel.all
      @users_with_ai_models = User.includes(:ai_models).where.not(ai_models: { id: nil })
     end
   
     def toggle_availability
       ai_model = AiModel.find(params[:id])
       ai_model.update(availability: !ai_model.availability)
       redirect_to admin_index_path, notice: "AI model availability toggled successfully."
     end

   
     private
   
     def authenticate_admin!
      puts "Current user: #{current_user.inspect}"
      return if current_user && current_user.admin? 
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
   end
   