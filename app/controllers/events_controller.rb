class EventsController < ApplicationController

  before_filter :signed_in_user, except: [:show]

  def show
    @event = Event.find(params[:id])
    if @event.internal? && (not signed_in?)
      flash[:notice] = "Bitte logge dich ein, um diese Funktion nutzen zu k&ouml;nnen.".html_safe
      redirect_back_or_to(root_path)
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event && @event.update_attributes(params[:event])
      flash[:success] = change_text
      flash[:success] = flash[:success].html_safe
      redirect_to @event
    else
      render 'edit'
    end
  end

  def new
    @event = Event.new(
      name: 'Name',
      start_at: DateTime.now,
      end_at: DateTime.now + 1.days,
      location: 'Ort',
    )
  end

  def create
    @event = Event.new(params[:event])
    if @event && @event.save!
      flash[:success] = 'Seite erstellt'
      redirect_to @event
    else
      flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator'
      redirect_to new_event_path
    end
  end

end