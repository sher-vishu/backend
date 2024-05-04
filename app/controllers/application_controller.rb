class ApplicationController < ActionController::Base
     before_action :authenticate_user!
     layout :choose_layout
   
     private
   
     def choose_layout
       current_user&.admin? ? 'admin' : 'user'
     end
end
