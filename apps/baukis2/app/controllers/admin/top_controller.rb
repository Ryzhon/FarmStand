class Admin::TopController < Admin::Base
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
