class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @today_tasks = current_user.list_items.not_done.expiring.order_by_list
    @ongoing_tasks = current_user.list_items.not_done.started
    @coming_tasks = current_user.list_items.not_started.not_done.not_expired.order_by_deadline
    @lists = current_user.lists
  end
end
