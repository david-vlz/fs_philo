class StaticPagesController < ApplicationController

  require 'will_paginate/array'

  def home
    @articles = Article.order('updated_at DESC')
    @articles = @articles.select { |a| a.visible? } unless signed_in?
    @articles = @articles.paginate(page: params[:page], per_page: 8)

    @events = Event.order('start_at ASC')
    @events = @events.select { |e| not e.internal? } unless signed_in?
    @events = @events.select do |e| 
      if e.end_at
        (e.end_at - DateTime.now) > 0 
      else
        e.start_at.today?
      end
    end
  end

  def impressum
  end

end
