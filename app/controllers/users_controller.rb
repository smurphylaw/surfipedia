class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:id])
    @wikis = @user.wikis.paginate(page: params[:title])
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, notice: "User updated"
    else
      redirect_to users_path, alert: "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, notice: "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
