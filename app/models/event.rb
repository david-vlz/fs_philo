# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  start_at      :datetime
#  end_at        :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  internal      :boolean          default(FALSE)
#  location      :string(255)
#  location_link :string(255)
#

class Event < ActiveRecord::Base

  attr_accessible :name, :start_at, :end_at, :internal, :location,
    :location_link

  has_event_calendar

  has_and_belongs_to_many :articles
  accepts_nested_attributes_for :articles

  validates(:name, presence: true, length: { maximum: 255, minimum: 3 })
  validates(:start_at, presence: true)
  validates(:location, presence: true)

  validate :end_must_be_after_start

  def end_must_be_after_start
    if end_at && start_at > end_at
      errors.add(:end_at, 'Das Ende der Veranstaltung sollte vor dem Anfang liegen')
    end
  end

end
