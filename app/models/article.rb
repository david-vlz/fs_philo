# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  category_id  :integer
#  visible      :boolean          default(FALSE)
#  precursor_id :integer
#  preview      :text
#

class Article < ActiveRecord::Base

  include InSuccession
  
  attr_accessible :user_id, :category_id, :body, :preview, :title, :visible,
    :precursor_id

  self.per_page = 8
  
  belongs_to :user
  belongs_to :category
  belongs_to :precursor, class_name: 'Article'
  has_and_belongs_to_many :events
  
  has_paper_trail :skip => [:precursor_id]

  before_save do
    self.title.strip!
    self.preview.strip!
  end

  validates(:body, presence: true)
  validates(:title, presence: true)
  validates(:preview, presence: true)
  validates(:user_id, presence: true)
  validates(:category_id, presence: true)
  validates(:precursor_id, uniqueness: true)

end
