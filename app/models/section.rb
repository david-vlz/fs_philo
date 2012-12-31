class Section < ActiveRecord::Base
  attr_accessible :body, :title
  
  belongs_to :article
  
end
