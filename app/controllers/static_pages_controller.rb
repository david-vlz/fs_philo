class StaticPagesController < ApplicationController
  def home
  	@categories = getCategories
  end
  
  def veranstaltungen
  end

  def contact
  end
end
