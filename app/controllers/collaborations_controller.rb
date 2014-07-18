class CollaborationsController < ApplicationController
  before_action :authenticate_user!


  def show
    @collaboration = Collaboration.find(params[:wiki_id])
  end

  def new
    @collaboration = Collaboration.new
  end

  def create
    @wiki = Wiki.friendly.find(params[:id])
    @collaboration = Collaboration.new(user_id: params[:user_id], wiki_id:  @wiki.id)

    if @collaboration.save
      redirect_to wikis_path, notice: "#{@wiki.title} wiki shared."
    else
      flash[:error] = "Error sharing wiki. Try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = Collaboration.find(params[:id])
    @collaboratoin.destroy
    flash[:notice] = "Collaboration successfully deleted."
    redirect_to wikis_path
  end

private
  def collaboration_params
    params.require(:collaboration).permit(:user_id, :wiki_id)
  end

end
