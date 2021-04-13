class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :redirect_param, only:[:edit]

  def index
    @prototypes = Prototype.all
    # binding.pry
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
    # binding.pry
  end

  def edit
    @prototype = Prototype.find(params[:id])
    # binding.pry
  end

  def update
    # binding.pry
    @prototype = Prototype.find(params[:id])
    # binding.pry
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render action: :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    # binding.pry
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def redirect_param
    unless user_signed_in?
      redirect_to action: index
    end
  end

end
