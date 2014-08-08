class WikisController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @wikis = current_user.wikis
    @wikis = Wiki.paginate(page: params[:page], per_page: 15)
    @collaborations = current_user.collaborations
  end

  def public
    @wikis = Wiki.where('private = ?', false)
  end

  def show
  end

  def new
    @wiki = current_user.wikis.build
  end

  def create
    @wiki = current_user.wikis.new(wikis_params)

    respond_to do |format|              
      if @wiki.save
        format.html { redirect_to @wiki, notice: "Wiki created." }
        format.json { render :show, status: :created, location: @wiki }
      else
        format.html { render :new }
        format.json { render json: @wiki.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])

    respond_to do |format|
      if @wiki.update(wikis_params)
          format.html { redirect_to @wiki, notice: "Wiki was updated" }
          format.json { render :show, status: :ok, location: @wiki }
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])

    respond_to do |format|
      if @wiki.destroy
        format.html { redirect_to wikis_url, notice: "Wiki was successfully deleted." }
        format.json { head :no_content }
      else
        flash[:error] = "There was an error deleting wiki. Please try again."
        render :show
      end
    end
  end

private
  def set_wiki
    @wiki = Wiki.friendly.find(params[:id])
  end

  def wikis_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end
end
