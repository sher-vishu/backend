class LogsController < ApplicationController
     def index
          @user_activity_logs = UserActivityLog.order(created_at: :desc).limit(10)
          @user_activity_logs = UserActivityLog.all
     end
   end