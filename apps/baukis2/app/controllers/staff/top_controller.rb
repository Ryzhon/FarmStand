class Staff::TopController < Staff::Base
    def index
        # raise 
        render action: "index"
    end
end
