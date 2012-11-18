# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  creator    :string(255)
#  text       :text
#  version    :integer
#  modifier   :string(255)
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ActiveRecord::Base
  attr_accessible :active, :creator, :modifier, :text, :title, :version
end
