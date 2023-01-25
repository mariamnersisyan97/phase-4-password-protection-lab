class UsersController < ApplicationController
    before_action :authorize, only: [:show]
    
# - Create a `UsersController` with a `create` method that responds to a `POST /signup` request. It should: create a new user; save their hashed password in
# the database; save the user's ID in the session hash; and return the user
# object in the JSON response.

def create 
    user = User.create(user_params)
    if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
    else
        render json: { error: user.errors.full_messages}, status: :unprocessable_entity
end
end

def show
    user = User.find_by(id: session[:user_id])
    render json: user
end
# - Add a `show` method to your `UsersController` that responds to a `GET /me`
# request. If the user is authenticated, return the user object in the JSON
# response.


    private

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
