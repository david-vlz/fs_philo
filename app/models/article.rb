class Article < ActiveRecord::Base
  attr_accessible :active, :creator, :modifier, :text, :title, :version
end
