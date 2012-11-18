# == Schema Information
#
# Table name: articles
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  body           :text
#  version        :integer
#  modifier       :string(255)
#  active         :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  fs_user_id     :integer
#  fs_category_id :integer
#

class Article < ActiveRecord::Base

	attr_accessible :active, :fs_user_id, :fs_category_id, :modifier, :body, :title, :version
  
	validates(:title, presence: true)
	validates(:body, presence: true)
	validates(:version, presence: true)
	validates(:active, presence: true)
	validates(:fs_user_id, presence: true)
	validates(:fs_category_id, presence: true)

end
