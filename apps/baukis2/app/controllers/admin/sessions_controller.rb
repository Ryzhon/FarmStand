class Admin::SessionsController < Admin::Base
    def new 
        if current_administrator
            redirect_to :admin_root
        else
            @form = Admin::LoginForm.new
            render action: "new"
        end
    end
    def create
       
        @form = Admin::LoginForm.new(params[:admin_login_form])
        if @form.email.present?
            administrator = 
            Administrator.find_by("LOWER(email) = ?", @form.email.downcase)
        end
        logger.debug(@form.password)

        # if staff_member
        if Admin::Authenticator.new(administrator).authenticate(@form.password)
            # session[:staff_member_id]=staff_member.id
            # flash.notice = "ログインしました"
            # redirect_to :staff_root

            if administrator.suspended?
                logger.debug("---------aaa")
                flash.now.alert = "アカウントが停止されています"
                render action: "new"
            else
                logger.debug("-----------bbb")

                session[:administrator_id] = administrator.id
                flash.notice = "ログインしました"
                redirect_to :admin_root
            end
        else
            logger.debug("--------------ccc")

            flash.now.alert = "メールアドレスまたはパスワードが正しくありません"
            render action: "new"
        end
    end

    def destroy
        session.delete(:administrator_id)
        flash.notice = "ログアウトしました。"
        redirect_to :admin_root
    end
end
