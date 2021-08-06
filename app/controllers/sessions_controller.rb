class SessionsController < ApplicationController
    def home
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    def new
    end

    def create
        if params[:user] != nil
            @user = User.find_by(username: params[:user][:username])
            if @user && @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                flash[:message] = "Incorrect Login Info Try Again"
                redirect_to "/login"
            end
        else 
            @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
            if @user
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                redirect_to root_path
            end
        end
    end

    private

    def auth
        request.env['omniauth.auth']
    end

end