# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  single_page  :boolean
#  visible      :boolean          default(FALSE)
#  precursor_id :integer
#

class Category < ActiveRecord::Base

  include InSuccession

  attr_accessible :name, :single_page, :visible, :precursor_id 

  has_many :articles
  belongs_to :precursor, class_name: 'Category'

  validates(:name, presence: true)
  validates(:precursor_id, uniqueness: true)

end
