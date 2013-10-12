class EventsController < ApplicationController

  before_filter :signed_in_user, except: [:show]

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    flash[:success] = ''
    if @event && @event.update_attributes(params[:event])
      flash[:success] << change_text
      flash[:success] = flash[:success].html_safe
      redirect_to @event
    else
      render 'edit'
    end
  end

end