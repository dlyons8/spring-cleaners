class WelcomeController < ApplicationController
    include ApplicationHelper
    
    def homepage
        if logged_in?
            redirect_to user_path(current_user)
        end
    end
end