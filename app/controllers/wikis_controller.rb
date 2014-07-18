class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = Wiki.paginate(page: params[:page], per_page: 15)
      if current_user
        @pwikis = Wiki.where(user_id: current_user.id, private: true)
    end
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    @wikis = Wiki.paginate(page: params[:page], per_page: 15)
    authorize @wiki
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def new
    @wiki = current_user.wikis.build
  end

  def create
    @wiki = current_user.wikis.build(wikis_params)
    
    @wiki.user_id = current_user.id unless current_user == nil
    @wiki.private = false unless wikis_params["private"] = 1

    authorize @wiki
    if @wiki.save
      flash[:notice] = "#{@wiki.title} wiki created."
      redirect_to @wiki 
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    @users = User.not_current_user(current_user)
    @users.reject! do |user|
      @wiki.WikisController.pluck(:user_id).include? user.id or
      user.id == current_user.id
    end
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    if @wiki.update_attributes(wikis_params)
        flash[:notice] = "#{@wiki.title} wiki was updated"
        redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "#{@wiki.title} wiki was successfully deleted."
      redirect_to root_url
    else
      flash[:error] = "There was an error deleting wiki. Please try again."
      render :show
    end
  end

  private

  def wikis_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end
end
