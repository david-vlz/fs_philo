module Mercury
  module Authentication

	include SessionsHelper

    def can_edit?
      if signed_in?
      	true
      else
		flash[:error] = 'Bitte logge dich ein, um diese Funktion zu nutzen.'
		false
	  end
    end

  end
end
