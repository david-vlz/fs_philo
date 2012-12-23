class StaticPagesController < ApplicationController
  def home
  	@categories = Category.all
  end
  
  def veranstaltungen
  end

  def contact
  end
end
