class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.password = params[:password].to_s
    if @user.save
      login = login(@user.email,@user.password)
      render json: {user: @user, token: login}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users/change_password
  def change_password
    if @user && @user.authenticate(user_params[:current_password])
      if user_params[:new_password].present? && user_params[:new_password].present?
        @user.password = user_params[:new_password]
        if @user.save
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        render json: { error: "Invalid Request" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Invalid Password!!" }, status: :unprocessable_entity
    end
  end

  # POST /users/reset_password
  def reset_password
    render json: {
                    "code": 0,
                    "message": "Password reset email sent to #{@user.email}. Please check your email address for further instructions.",
                  }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id]) if params[:id].present?
      return if @user.present?
      @user = user
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(
        User.column_names.map(&:to_sym).push(:current_password, :new_password)
      )
    end

    def login(email,password) 
      command = AuthenticateUser.call(email, password)
      if command.success?
        return { auth_token: command.result}
      end
    end

    def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      @user || errors.add(:token, 'Invalid token') && nil
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      if request.headers['Authorization'].present?
        return request.headers['Authorization'].split(' ').last
      else
        errors.add(:token, 'Missing token')
      end
      nil
    end
end
