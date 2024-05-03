class SessionsController < Devise::SessionsController
     def create
       super
       UserActivityLog.create(user_id: current_user.id, activity: 'Logged in')
     end
   end
   