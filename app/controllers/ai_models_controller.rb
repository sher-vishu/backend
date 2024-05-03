class AiModelsController < ApplicationController
     before_action :authenticate_user!
   
     def create
       @ai_model = current_user.ai_models.build(ai_model_params)
       if @ai_model.save
         redirect_to @ai_model, notice: 'AI model was successfully created.'
       else
         render :new
       end
     end
   
     def update
       @ai_model = current_user.ai_models.find(params[:id])
       if @ai_model.update(ai_model_params)
         current_user.update_unavailable_models_flag
         redirect_to @ai_model, notice: 'AI model was successfully updated.'
       else
         render :edit
       end
     end

     def toggle_availability
      ai_model = current_user.ai_models.find(params[:id])
      ai_model.update(availability: !ai_model.availability)
      redirect_to admin_index_path, notice: "AI model availability toggled successfully."
    end
   
     private
   
     def ai_model_params
       params.require(:ai_model).permit(:name, :availability)
     end
   end
   