class CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: [:show, :edit, :update, :destroy]
  before_action :set_wiki, only: [:new, :create, :index]
  
  def index
    @collaborators = @wiki.collaborators
  end

  def show
    @users = User.all
  end

  def new
    @users = User.find(current_user.id)
    @collaborator = @wiki.collaborators.new
  end

  def edit
  end

  def create
    @collaborator = @wiki.collaborators.build(collaborator_params)
    
    respond_to do |format|
      if @collaborator.save
        format.html { redirect_to @wiki, notice: 'Successfully added collaborators' }
        format.json { render :show, status: :created, location: @collaborator }
      else
        format.html { render :new }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @collaboration.destroy
        format.html { redirect_to collaborators_url, notice: "Collaboration was removed." }
        format.json { head :no_content}
      else
        flash[:error] = "Collaboration couldn't be removed. Try again."
      end
    end
  end

  def update
    respond_to do |format|
      if @collaborator.update(collaborator_params)
        format.html { redirect_to @collaborator, notice: 'Collaborators was successfully updated' }
        format.json { render :show, status: :ok, location: @collaborator }
      else
        format.html { render :edit }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def set_collaborator
    @collaborator = Collaborator.find(params[:id])
  end

  def set_wiki
    @wiki = Wiki.friendly.find(params[:wiki_id])
  end

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
