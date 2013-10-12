class StaticPagesController < ApplicationController

  def home
    articles = Article.order('updated_at DESC')
    articles = articles.select { |a| a.visible? } unless signed_in?
    @articles = articles.paginate(page: params[:page], per_page: 8)

    @events = Event.all
  end

  def impressum
  end

end
