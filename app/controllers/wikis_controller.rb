class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = Wiki.paginate(page: params[:page], per_page: 15)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    @wikis = Wiki.paginate(page: params[:page], per_page: 15)
    authorize @wiki
    @collaborations = @wiki.collaborations
    @collaboration = Collaboration.new
  end

  def new
    @wiki = current_user.wikis.build
    authorize @wiki
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
    @collaborations = @wiki.collaborations
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

  def collaborators
    @collaborators = @wiki.collaborators    
    @users = User.all
  end

  def update_collaborators
    @wiki.replace_collaborators params[:collaborators]
    redirect_to collaborators_wiki_path(@wiki), notice: 'Collaborators updated'
  end

  private

  def wikis_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end
end
