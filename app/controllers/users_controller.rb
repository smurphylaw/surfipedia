class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @users = User.all
    @wikis = @user.wikis.paginate(page: params[:title])
  end

end
