class CollaborationsController < ApplicationController
  
  def new
    @users = User.all
  end

  def create
    @wiki = Wiki.find( params[:wiki_id] )
    @collaborations = @wiki.collaborations

    @collaboration = current_user.comments.build(collaboration_params)
    @comment.wiki = @wiki
    @new_comment = Collaboration.new

    if @collaboration.save
      flash[:notice] = "Collaborations was saved."
    else
      flash[:error] = "There was an error saving the collaborations. Please try again."
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])

    @comment = @wiki.comments.find(params[:id])

    if @collaboration.destroy
      flash[:notice] = "Collaboration was removed."
    else
      flash[:error] = "Collaboration couldn't be removed. Try again."
    end

  end

private
  def collaboration_params
    params.require(:collaboration).permit(:wiki_id)
  end
end
