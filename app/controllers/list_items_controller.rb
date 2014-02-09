class ListItemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    list = List.find(params[:list])
    ListItem.create!(list: list, content: params[:content])

    render partial: "lists/normal", locals: { list: list }
  end

  def timer_start
    list_item = ListItem.find(params[:id])
    list_item.timer_start!
    
    render text: "ok"
  end

  def timer_stop
    list_item = ListItem.find(params[:id])
    list_item.timer_stop!
    
    render text: "ok"    
  end

  def done
    list_item = ListItem.find(params[:id])
    list_item.done!
    list = List.find(list_item.list_id)

    render partial: "lists/normal", locals: { list: list }
  end

  def set_deadline
    list_item = ListItem.find(params[:id])
    list_item.update_attribute(:deadline_at, params[:deadline])
    render text: "ok"
  end

  def start
    list_item = ListItem.find(params[:id])
    list_item.start!
    render text: "ok"
  end
end
