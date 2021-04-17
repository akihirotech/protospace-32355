class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :redirect_param, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
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
    @comment = Comment.new
    @comments = @prototype.comments
    # binding.pry
  end

  def edit
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

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def redirect_param
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end

end
