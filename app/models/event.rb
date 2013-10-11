# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  internal   :boolean          default(FALSE)
#

class Event < ActiveRecord::Base

	attr_accessible :name, :start_at, :end_at, :internal

  has_event_calendar

  validates(:name, presence: true, length: { maximum: 255, minimum: 3 })
  validates(:start_at, presence: true)
  validates(:end_at, presence: true)

  validate :end_must_be_after_start, on: :create

  def end_must_be_after_start
  	errors.add(:end_at, 'must be after start_at') if start_at > end_at
  end

end
