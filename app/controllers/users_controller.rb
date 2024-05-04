class UsersController < ApplicationController
     before_action :authenticate_user!
     before_action :set_user, only: [:show, :edit, :update, :destroy]
     layout :choose_layout

     def choose_layout
      current_user.admin? ? 'admin' : 'user'
     end
     
     def associate_ai_models_form
      @user = current_user
      @ai_models = AiModel.all
     end

     def associate_ai_models
       @user = current_user
       ai_model_ids = params[:user][:ai_model_ids].reject(&:empty?) 
       @user.ai_model_ids = ai_model_ids 
       redirect_to users_path, notice: "AI models associated successfully."
     end

     def index
      @users = User.all
    end
  
    def toggle_availability
      ai_model = AiModel.find(params[:id])
      ai_model.update(availability: !ai_model.availability)
      redirect_to users_path, notice: "AI model availability toggled successfully."
    end

    def show
      # This will be called when a specific user's page is requested
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        redirect_to @user, notice: 'User was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      # This will be called when editing a specific user's details
    end
  
    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
   end
   