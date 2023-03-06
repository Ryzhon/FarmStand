class Admin::TopController < Admin::Base
    skip_before_aciton :authorize
    def index
        # render action: "index"
        if current_administrator
            render action: "dashboard"
        else
            render action: "index"
        # render action: "dashboard"
        end
    end
end
