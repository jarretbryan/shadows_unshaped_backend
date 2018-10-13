class Api::V1::UsersController < ApplicationController

    before_action :get_user, only: [:show, :update, :destroy]

    def index
        @users = User.all
        render json: @users
    end

    def show
        render json: @user
    end


    def register
        # @user = User.find_or_create_by(register_user_params)
        @user = User.create(register_user_params) 
        if @user.save
            response ={message: 'User registration accepted!'}
            render json: @user, status: :accepted
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
        end
    end

    # def profile
    #     if logged_in
    #         render json: {user: UserSerializer.new(current_user)}, status: :accepted
    #     else
    #         render json: {message: 'User not found'}, status: :not_found
    #     end
    # end

    def destroy
        @user.delete 
    end

    private

    def get_user
        @user = User.find(params[:id])
    end

    def register_user_params
        # params.permit(:username, :password_digest)
        params.permit(:email, :password, :username, :profile_image)
    end

end
