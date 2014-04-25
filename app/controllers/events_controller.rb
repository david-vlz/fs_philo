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
    if @event \
    && @event.update_attributes(params[:event]) then
      if not params[:article][:id].empty? then
        add_article_association(params[:article][:id])
      end
      if params[:article_destroy_ids] \
      && params[:article_destroy_ids].any? then
        params[:article_destroy_ids].each do |id| 
          remove_article_association id
        end
      end
      flash[:success] = change_text
      flash[:success] = flash[:success].html_safe
      redirect_to root_path
    else
      flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator'
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
    if @event && @event.save! then
      if not params[:article][:id].empty? then
        add_article_association(params[:article][:id])
      end
      flash[:success] = 'Seite erstellt'
      redirect_to root_path
    else
      flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator'
      redirect_to new_event_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event && @event.destroy then
      flash[:success] = 'Veranstaltung entfernt'
      redirect_back_or_to root_path
    else
      flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator'
      redirect_back_or_to root_path
    end
  end

  private

    def add_article_association(article_id)
      article = Article.find(article_id)
      if article then 
        if not @event.articles(true).exists?(article) then
          @event.articles.push(article)
        else
          true
        end
      end
    end

    def remove_article_association(article_id)
      article = Article.find(article_id)
      article && @event.articles.destroy(article)
    end

end