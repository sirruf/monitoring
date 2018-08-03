# frozen_string_literal: true

#
# Events Model
#
class Event < ApplicationRecord
  scope :unresolved, -> { where(solved: false) }

  belongs_to :site

  validates :site_id, :code, :message, presence: true

  before_validation :find_last_uuid
  after_commit :send_notification

  private

  def send_notification
    if success? || solved == true
      NotificationMailer.with(event_id: id).notification_email.deliver
    else
      Notifications.send(self)
    end
  end

  def success?
    saved_changes.include?('solved') && solved == true
  end

  def find_last_uuid
    last_uuid = unresolved_for_site.last&.uuid
    self.uuid ||= last_uuid.present? ? last_uuid : SecureRandom.uuid
  end

  def unresolved_for_site
    site.present? ? site.events.unresolved : []
  end
end
