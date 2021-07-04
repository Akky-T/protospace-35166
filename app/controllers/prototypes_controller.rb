class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :move_to_index, :show]
  before_action :move_to_index1, only: [:edit]
  before_action :move_to_index2, only: [:new]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path
    else
      @prototype = Prototype.find(params[:id])
      render :edit
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to prototype_path(@prototype)
    else
      render :new
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index1
    redirect_to root_path unless current_user.id == @prototype.user.id
  end

  def move_to_index2
    redirect_to root_path unless user_signed_in?
  end
end
