# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer
#

class Section < ActiveRecord::Base
  attr_accessible :body, :title
  
  belongs_to :article
  
end
