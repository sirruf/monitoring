# frozen_string_literal: true

#
# Site Model
#
class Site < ApplicationRecord
  scope :active, -> { where(active: true) }

  has_many :events, dependent: :destroy

  validates :url, :name, :owner_email, presence: true

  def check
    puts "Checking URL: #{url}"
    result = Tools::HTTPRequest.check(url)
    Events.create_or_update(self, result)
    true
  rescue StandardError
    update_attribute(:active, false)
    false
  end

  def success?
    !events.unresolved.present?
  end
end
