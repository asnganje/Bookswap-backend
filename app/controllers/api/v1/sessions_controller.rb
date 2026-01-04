class Api::V1::SessionsController < Devise::RegistrationsController
  respond_to :json
  before_action :authenticate_user!, only: [ :destroy ]
  def create
    user_params = params.require(:user).permit(:email, :password)
    user = User.find_by(email: user_params[:email])

    if user&.valid_password?(user_params[:password])
      token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first

      render json: {
        msg: "success login",
        token: token,
        user: {
          id: user.id,
          email: user.email,
          fullname: user.fullname
        }
      },
      status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unprocessable_entity
    end
  end

  def destroy
    request.env["warden"].logout(:user)
    render json: { msg: "Logged out successfully" }, status: :ok
  end
end
