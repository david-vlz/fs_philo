class Article < ActiveRecord::Base
  attr_accessible :active, :created, :creator, :modified, :modifier, :text, :title, :version
end
