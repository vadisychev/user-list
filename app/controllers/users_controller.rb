class UsersController < ApplicationController

    before_action :find_user, only: [:show, :edit, :update, :destroy]
    before_action :is_registered, only: [:update, :create]
    # before_action :if_admin, only: [:edit, :update, :destroy]

    # /users
    def index
        @users = User.all
    end

    # /users/id GET
    def show
        unless @user
            render plain: "Page not found", status: 404
        end
    end

    # called by new POST
    def create
        @user = User.create(user_data)
        if @user.errors.empty?
            redirect_to user_path(@user)
            UsersMailer.reg_notification(@user).deliver
        else
            render "new"
        end
    end

    # /users/new GET
    def new
        @user = User.new
    end

    # called by edit PUT
    def update
        @user.update(user_data)
        if @user.errors.empty?
            redirect_to user_path(@user)
            UsersMailer.upd_notification(@user).deliver
        else
            render "edit"
        end
    end

    # /users/id/edit GET
    def edit
    end

    # /users/id DELETE
    def destroy
        @user.destroy
        redirect_to action: "index"
    end

    private

        def user_data
            params.require(:user).permit(:name, :email)
            # params.permit(:name, :email)
            # params.permit
        end

        def find_user
            @user = User.find(params[:id])
        end

        def if_admin
            render plain: "Access denied", status: 403 unless params[:admin]
        end

        def is_registered
            puts "================================"
            p params[:email]
            p params[:user]
            userparams = params[:user]
            p userparams[:email]
            puts "================================"
            if User.exists?(email: userparams[:email])
                puts "================================"
                puts "user have been registered"
                puts "================================"
                render plain: "User with such email #{userparams[:email]} have already been registered."
            end
        end

end



# /create?data[name]=testParams&data[email]=test@param.com