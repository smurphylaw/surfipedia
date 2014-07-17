class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = Wiki.paginate(page: params[:page], per_page: 15)
    authorize @wikis
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
    authorize! :new, @wiki, message: "You need to sign up to create wikis."
  end

  def create
    @wiki = current_user.wikis.build(wikis_params)
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
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
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
    params.require(:wiki).permit(:title, :body, :public)
  end
end
