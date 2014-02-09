class ListsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
  end

  def create
    @list = List.new create_list_params
    @list.user = current_user

    if @list.valid?
      @list.save
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def create_list_params
    params.require(:list).permit(:title)
  end
end
